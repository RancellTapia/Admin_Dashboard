import 'package:admin_dashboard/models/announcements_model.dart';
import 'package:admin_dashboard/providers/announcements_provider.dart';
import 'package:admin_dashboard/ui/dialog/responsive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:universal_html/html.dart' as html;

class AnnouncementDialog extends StatefulWidget {
  final Announcement? announcement;
  const AnnouncementDialog({super.key, this.announcement});

  @override
  State<AnnouncementDialog> createState() => _AnnouncementDialogState();
}

class _AnnouncementDialogState extends State<AnnouncementDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isActive = true;
  DateTime? _visibleFrom;
  DateTime? _visibleTo;

  bool _isSaving = false;
  String? _dateError;

  XFile? _selectedImage;
  Uint8List? _imagePreviewBytes;
  bool _hasRemoteImage = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final announcement = widget.announcement;
    if (announcement != null) {
      _titleController.text = announcement.title;
      _contentController.text = announcement.content;
      _isActive = announcement.isActive;
      _visibleFrom = announcement.visibleFrom;
      _visibleTo = announcement.visibleTo;
      if (announcement.imageUrl != null && announcement.imageUrl!.isNotEmpty) {
        _loadNetworkImage(announcement.imageUrl!);
      }
    }
  }

  Future<void> _loadNetworkImage(String url) async {
    try {
      final response = await NetworkAssetBundle(Uri.parse(url)).load(url);
      final bytes = response.buffer.asUint8List();
      setState(() {
        _imagePreviewBytes = bytes;
        _hasRemoteImage = true;
      });
    } catch (_) {}
  }

  Future<void> _pickDate({
    required String label,
    required DateTime? initialDate,
    required Function(DateTime) onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      helpText: label,
    );
    if (picked != null) onPicked(picked);
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final input = html.FileUploadInputElement()..accept = 'image/*';
      input.click();

      input.onChange.listen((event) async {
        final file = input.files?.first;
        if (file != null) {
          final reader = html.FileReader();
          reader.readAsArrayBuffer(file);
          await reader.onLoad.first;

          final bytes = reader.result as Uint8List;

          setState(() {
            _imagePreviewBytes = bytes;
            _hasRemoteImage = false;
          });
        }
      });
    } else {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImage = image;
          _imagePreviewBytes = bytes;
          _hasRemoteImage = false;
        });
      }
    }
  }

  Future<String?> _uploadImageToSupabase(
      Uint8List bytes, String fileExt) async {
    final userId = Supabase.instance.client.auth.currentUser?.id ?? 'anonymous';
    final fileName = 'announcement_${const Uuid().v4()}.$fileExt';
    final filePath = '$userId/$fileName';

    final response = await Supabase.instance.client.storage
        .from('image')
        .uploadBinary(filePath, bytes,
            fileOptions: FileOptions(contentType: 'image/$fileExt'));

    if (response.isEmpty) return null;

    final publicUrl =
        Supabase.instance.client.storage.from('image').getPublicUrl(filePath);

    return publicUrl;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnnouncementsProvider>(context, listen: false);
    final isEditing = widget.announcement != null;

    return ResponsiveDialog(
      title: Text(isEditing ? 'Editar anuncio' : 'Nuevo anuncio'),
      content: _isSaving
          ? const SizedBox(
              width: 400,
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _titleController,
                          decoration:
                              const InputDecoration(labelText: 'Título'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Requerido'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SwitchListTile(
                          value: _isActive,
                          title: const Text('Activo'),
                          onChanged: (value) =>
                              setState(() => _isActive = value),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Contenido'),
                    maxLines: 4,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Transform(
                          transform: Matrix4.translationValues(-12, 0, 0),
                          child: ListTile(
                            title: const Text('Visible desde'),
                            subtitle: Text(
                              _visibleFrom != null
                                  ? _visibleFrom!
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]
                                  : 'No definido',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                _pickDate(
                                  label: 'Visible desde',
                                  initialDate: _visibleFrom,
                                  onPicked: (date) =>
                                      setState(() => _visibleFrom = date),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Visible hasta'),
                          subtitle: Text(
                            _visibleTo != null
                                ? _visibleTo!.toLocal().toString().split(' ')[0]
                                : 'No definido',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _pickDate(
                                label: 'Visible hasta',
                                initialDate: _visibleTo,
                                onPicked: (date) =>
                                    setState(() => _visibleTo = date),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_dateError != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        _dateError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo),
                        label: const Text('Seleccionar imagen'),
                      ),
                      if (isEditing &&
                          _imagePreviewBytes == null &&
                          widget.announcement?.imageUrl != null &&
                          widget.announcement!.imageUrl!.isNotEmpty) ...[
                        Image.network(widget.announcement!.imageUrl!,
                            height: 100),
                      ],
                      if (_imagePreviewBytes != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Image.memory(_imagePreviewBytes!, height: 100),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _imagePreviewBytes = null;
                                    _hasRemoteImage = false;
                                  });
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                label: const Text('Eliminar imagen'),
                              )
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
      actions: _isSaving
          ? []
          : [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text(isEditing ? 'Editar' : 'Guardar'),
                onPressed: () async {
                  final userId = Supabase.instance.client.auth.currentUser?.id;

                  setState(() => _dateError = null);
                  if (_visibleFrom != null &&
                      _visibleTo != null &&
                      _visibleTo!.isBefore(_visibleFrom!)) {
                    setState(() => _dateError =
                        'La fecha "Visible hasta" no puede ser anterior a "Visible desde".');
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    setState(() => _isSaving = true);

                    String? imageUrl;
                    if (_imagePreviewBytes != null) {
                      final ext = _selectedImage != null
                          ? path
                              .extension(_selectedImage!.path)
                              .replaceAll('.', '')
                          : 'png';
                      imageUrl = await _uploadImageToSupabase(
                          _imagePreviewBytes!, ext);
                    }

                    final announcement = Announcement(
                      id: widget.announcement?.id ?? '',
                      title: _titleController.text,
                      content: _contentController.text,
                      isActive: _isActive,
                      visibleFrom: _visibleFrom,
                      visibleTo: _visibleTo,
                      imageUrl: imageUrl ??
                          (_imagePreviewBytes == null && !_hasRemoteImage
                              ? null
                              : widget.announcement?.imageUrl),
                      createdBy: userId ?? 'unknown',
                    );

                    if (isEditing) {
                      await provider.updateAnnouncement(
                          announcement.id, announcement);
                    } else {
                      await provider.addAnnouncement(announcement);
                    }

                    if (mounted) {
                      setState(() => _isSaving = false);
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
    );
  }
}
