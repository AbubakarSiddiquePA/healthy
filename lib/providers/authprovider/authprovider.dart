import 'package:flutter/material.dart';

class LoginFormState extends ChangeNotifier {
  String email = "";
  String password = "";
  String fullname = "";
  bool login = false;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setFullname(String value) {
    fullname = value;
    notifyListeners();
  }

  void toggleLogin() {
    login = !login;
    notifyListeners();
  }
}
