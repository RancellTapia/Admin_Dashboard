import 'package:admin_dashboard/models/announcements_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnnouncementsProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  bool isLoading = false;
  bool _hasFetched = false;

  /// 🔹 Obtener todos los anuncios (incluso inactivos, si el usuario es admin)
  Future<void> fetchAnnouncements() async {
    if (_hasFetched) return; // Solo carga una vez
    _hasFetched = true;
    isLoading = true;
    notifyListeners();

    final response = await _supabase
        .from('announcements')
        .select()
        .order('created_at', ascending: false);

    _announcements =
        response.map<Announcement>((a) => Announcement.fromMap(a)).toList();

    print('Announcements: $_announcements.length');

    isLoading = false;
    notifyListeners();
  }

  void refreshAnnouncements() async {
    _hasFetched = false;
    await fetchAnnouncements();
  }

  /// 🔹 Crear nuevo anuncio
  Future<void> addAnnouncement(Announcement a) async {
    final response = await _supabase
        .from('announcements')
        .insert(a.toMap())
        .select()
        .single();

    final newAnnouncement = Announcement.fromMap(response);
    _announcements.insert(0, newAnnouncement);
    notifyListeners();
  }

  /// 🔹 Editar anuncio
  Future<void> updateAnnouncement(String id, Announcement updated) async {
    await _supabase.from('announcements').update(updated.toMap()).eq('id', id);
    final index = _announcements.indexWhere((a) => a.id == id);

    print('updateAnnouncement: ${updated.toMap()}');
    if (index != -1) {
      _announcements[index] = updated;
    }
    notifyListeners();
  }

  /// 🔹 Eliminar anuncio
  Future<void> deleteAnnouncement(String id) async {
    await _supabase.from('announcements').delete().eq('id', id);
    _announcements.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  /// 🔹 Duplicar anuncio
  Future<void> duplicateAnnouncement(Announcement original) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    final newAnnouncement = Announcement(
      id: '', // Supabase genera uno nuevo automáticamente
      title: '${original.title} (copia)',
      content: original.content,
      imageUrl: original.imageUrl,
      visibleFrom: original.visibleFrom,
      visibleTo: original.visibleTo,
      isActive: original.isActive,
      createdBy:
          userId ?? 'unknown', // Provide a default value if userId is null
    );

    final inserted = await _supabase
        .from('announcements')
        .insert(newAnnouncement.toMap())
        .select()
        .single();

    final duplicated = Announcement.fromMap(inserted);
    _announcements.insert(0, duplicated); // Opcional: mostrar arriba
    notifyListeners();
  }
}
