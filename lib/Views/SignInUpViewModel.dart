import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafeq_app/services/AuthService.dart';

class SignInUpViewModel extends ChangeNotifier {
  String username = "";
  String email = "";
  String password = "";
  String passwordConfirmation = "";

  String warningMessage = "";
  bool isShowingWarning = false;

  final authService = AuthService();

  updateEmailAndPass(String? username, String email, String password, String? passwordConfirmation) {
    this.username = username ?? "";
    this.email = email;
    this.password = password;
    this.passwordConfirmation = passwordConfirmation ?? "";
    notifyListeners();
  }

  signInWithEmailAndPassword() async {
    print("Logging in with email: $email and password: $password");
    try {
      await authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      print((e as FirebaseAuthException).code);
      if (e is FirebaseAuthException && e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showWarning("كلمة المرور غير صحيحة");
      } else if (e is FirebaseAuthException && e.code == 'too-many-requests') {
        showWarning("تم إدخال كلمة المرور خطأ عدة مرات، يرجى المحاولة لاحقاً");
      } else {
        // You can add more error handlers here or show a generic error message
        showWarning("حدث خطأ أثناء تسجيل الدخول");
      }
    }
  }

  signUpWithEmailAndPassword(context) async {
    if (isValidPassword()) {
      print("SignUp with email: $email and password: $password");
      authService.signUpWithEmailAndPassword(email, password, username);
      Navigator.pop(context);
    }
  }

  void hideWarning() {
    isShowingWarning = false;
    notifyListeners();
  }

  void showWarning(String message) {
    warningMessage = message;
    isShowingWarning = true;
    notifyListeners();
  }

  bool isValidPassword() {
    if (password != passwordConfirmation) {
      showWarning("كلمة السر غير متطابقة");
      return false;
    }

    // Check for the length
    if (password.length < 8) {
      showWarning("كلمة السر قصيرة جداً");
      return false;
    }

    // Check for the presence of numbers
    if (!RegExp(r'\d').hasMatch(password)) {
      showWarning("كلمة السر يجب أن تحتوي على رقم واحد على الأقل");
      return false;
    }

    // Check for the presence of both lowercase and uppercase letters
    if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password)) {
      showWarning("كلمة السر يجب أن تحتوي على حروف كبيرة وصغيرة");
      return false;
    }
    hideWarning();
    return true;
  }
}
