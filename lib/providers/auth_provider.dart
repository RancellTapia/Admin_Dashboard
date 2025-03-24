import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart' as app_storage;
import 'package:admin_dashboard/services/navigation_services.dart';
import 'package:admin_dashboard/services/supa_base_services.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _supabaseService.logIn(email, password);

      if (response.session != null && response.user != null) {
        authStatus = AuthStatus.authenticated;

        _token = response.session!.accessToken;
        app_storage.LocalStorage.prefs.setString('token', _token!);

        notifyListeners();

        NavigationService.replaceTo(Flurorouter.dashboardRoute);
      } else {
        throw Exception("Login fallido. Revisa tus credenciales.");
      }
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();

      print('Error en login: $e');
    }
  }

  Future<void> register(
      String firstName, String lastName, String email, String password) async {
    try {
      final response =
          await _supabaseService.signUp(firstName, lastName, email, password);

      if (response.session != null && response.user != null) {
        authStatus = AuthStatus.authenticated;

        _token = response.session!.accessToken;
        app_storage.LocalStorage.prefs.setString('token', _token!);
        print(_token);

        notifyListeners();

        NavigationService.replaceTo(Flurorouter.dashboardRoute);
      }
    } catch (e) {
      print('Error al registrar: $e');
    }
  }

  Future<bool> isAuthenticated() async {
    final token = app_storage.LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    authStatus = AuthStatus.authenticated;
    notifyListeners();

    return true;
  }
}
