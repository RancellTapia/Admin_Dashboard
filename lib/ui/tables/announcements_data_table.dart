import 'package:admin_dashboard/models/announcements_model.dart';
import 'package:admin_dashboard/ui/dialog/announcement_dialog.dart';
import 'package:admin_dashboard/ui/dialog/responsive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/announcements_provider.dart';

class AnnouncementsDataTable extends StatelessWidget {
  const AnnouncementsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnnouncementsProvider>(context);
    final announcements = provider.announcements;

    if (announcements.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: DataTable(
                columnSpacing: 130,
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                border: TableBorder(
                  horizontalInside:
                      BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
                columns: const [
                  DataColumn(label: Text('Título')),
                  DataColumn(label: Text('Activo')),
                  DataColumn(label: Text('Visible Desde')),
                  DataColumn(label: Text('Visible Hasta')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: announcements.map((a) {
                  return DataRow(cells: [
                    DataCell(Text(a.title)),
                    DataCell(Icon(
                      a.isActive ? Icons.check_circle : Icons.cancel,
                      color: a.isActive ? Colors.green : Colors.red,
                    )),
                    DataCell(
                        Text(a.visibleFrom?.toString().split(' ')[0] ?? '—')),
                    DataCell(
                        Text(a.visibleTo?.toString().split(' ')[0] ?? '—')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          tooltip: 'Ver detalles',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ResponsiveDialog(
                                title: const Text('Detalle del anuncio'),
                                content: _DialogContent(
                                  a: a,
                                  dialogWidth: 600,
                                  dialogHeight: 520,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.grey[850]),
                          tooltip: 'Duplicar',
                          onPressed: () async {
                            await provider.duplicateAnnouncement(a);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AnnouncementDialog(announcement: a),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Eliminar anuncio'),
                                content: const Text('¿Estás seguro?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await provider.deleteAnnouncement(a.id);
                            }
                          },
                        )
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    super.key,
    required this.dialogWidth,
    required this.dialogHeight,
    required this.a,
  });

  final double dialogWidth;
  final double dialogHeight;
  final Announcement a;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          if (a.imageUrl != null && a.imageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                a.imageUrl!,
                // height: 150,
                width: dialogWidth,
              ),
            ),
            const SizedBox(height: 2),
          ],
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.title, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Título: ${a.title}')),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.toggle_on, size: 20),
                    const SizedBox(width: 8),
                    Text('Activo: ${a.isActive ? 'Sí' : 'No'}'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    Text(
                        'Desde: ${a.visibleFrom?.toString().split(' ')[0] ?? '—'}'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    Text(
                        'Hasta: ${a.visibleTo?.toString().split(' ')[0] ?? '—'}'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.description, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text('Contenido: ${a.content}')),
            ],
          ),
        ],
      ),
    );
  }
}
