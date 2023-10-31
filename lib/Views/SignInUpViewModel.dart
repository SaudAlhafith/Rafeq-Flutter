import 'package:flutter/material.dart';
import 'package:rafeq_app/services/AuthService.dart';

class SignInUpViewModel extends ChangeNotifier {
  String email = "";
  String password = "";

  final authService = AuthService();

  

  updateEmailAndPass(String email, String password) {
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  signInWithEmailAndPassword() {
    print("Logging in with email: $email and password: $password");
    authService.singInWithEmailAndPassword(email, password);
  }

  signUpWithEmailAndPassword() {
    print("SignUp with email: $email and password: $password");
    authService.signUpWithEmailAndPassword(email, password);
  }
}
