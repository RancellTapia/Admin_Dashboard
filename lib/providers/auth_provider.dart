import 'package:admin_dashboard/services/local_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    // Petición HTTP
    _token = 'dsfgjygsdjygsdfkfgsdfgfgtytuyfutygsdfyuhgyu';

    LocalStorage.prefs.setString('token', _token!);

    print(_token);

    notifyListeners();
  }
}
