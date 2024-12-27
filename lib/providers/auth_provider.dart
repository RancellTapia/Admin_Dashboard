import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    // Petición HTTP
    _token = 'dsfgjygsdjygsdfkfgsdfgfgtytuyfutygsdfyuhgyu';

    print(_token);

    notifyListeners();
  }
}
