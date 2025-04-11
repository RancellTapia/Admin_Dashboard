import 'package:admin_dashboard/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<News> _news = [];
  List<News> get news => _news;

  bool isLoading = false;
  bool _hasFetched = false;

  Future<void> fetchNews() async {
    if (_hasFetched) return;
    _hasFetched = true;
    isLoading = true;
    notifyListeners();

    final response = await _supabase
        .from('news')
        .select()
        .order('created_at', ascending: false);

    _news = response.map<News>((a) => News.fromMap(a)).toList();

    isLoading = false;
    notifyListeners();
  }

  void refreshNews() async {
    _hasFetched = false;
    await fetchNews();
  }

  Future<void> addNews(News a) async {
    final response =
        await _supabase.from('news').insert(a.toMap()).select().single();

    final newNews = News.fromMap(response);
    _news.insert(0, newNews);
    notifyListeners();
  }

  Future<void> updateNews(String id, News updated) async {
    await _supabase.from('news').update(updated.toMap()).eq('id', id);
    final index = _news.indexWhere((a) => a.id == id);

    if (index != -1) {
      _news[index] = updated;
    }
    notifyListeners();
  }

  Future<void> deleteNews(String id) async {
    await _supabase.from('news').delete().eq('id', id);
    _news.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  Future<void> duplicateNews(News original) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    final newNews = News(
      id: '',
      title: '${original.title} (copia)',
      content: original.content,
      imageUrl: original.imageUrl,
      visibleFrom: original.visibleFrom,
      visibleTo: original.visibleTo,
      isActive: original.isActive,
      createdBy: userId ?? 'unknown',
    );

    final inserted =
        await _supabase.from('news').insert(newNews.toMap()).select().single();

    final duplicated = News.fromMap(inserted);
    _news.insert(0, duplicated);
    notifyListeners();
  }
}
