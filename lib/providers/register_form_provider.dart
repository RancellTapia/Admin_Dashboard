import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      print('$firstName - $email - $password');
      return true;
    } else {
      return false;
    }
  }
}
