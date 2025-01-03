import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      print('$name - $email - $password');
      return true;
    } else {
      return false;
    }
  }
}
