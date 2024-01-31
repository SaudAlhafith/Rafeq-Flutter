import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/CustomElevatedButton.dart';
import 'package:rafeq_app/Views/SignInUpViewModel.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'package:rafeq_app/Views/Settings/DarkThemeProvider.dart';

import '../generated/l10n.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signInUpViewModel = Provider.of<SignInUpViewModel>(context);
    var emailController = TextEditingController(text: signInUpViewModel.email);
    var passwordController =
        TextEditingController(text: signInUpViewModel.password);
    var localizations = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'AppFiles/Newbackground.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Rfeeq Logo
              Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Image.asset(
                          'AppFiles/RfeeqLogo.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Text(
                        localizations.appName,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w400),
                      )
                    ],
                  )),

              // Register Form
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        )
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(localizations.login,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C96F9),
                          )),
                      const SizedBox(height: 30),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: localizations.email,
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: localizations.password,
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (signInUpViewModel.isShowingWarning) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              signInUpViewModel.warningMessage,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red.withOpacity(0.8),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.warning,
                                size: 12, color: Colors.red.withOpacity(0.8)),
                          ],
                        ),
                      ],
                      const SizedBox(height: 15),
                      Container(
                          width: double.infinity,
                          height: 40,
                          child: CustomElevatedButton(
                            onPressed: () {
                              String email = emailController
                                  .text; // Get the latest email input by the user
                              String password = passwordController.text;
                              signInUpViewModel.updateEmailAndPass(
                                  null,
                                  emailController.text,
                                  passwordController.text,
                                  null);
                              signInUpViewModel.signInWithEmailAndPassword();
                            },
                            label: Text(localizations.login),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          )),
                      const SizedBox(
                          height:
                              10), // A bit of spacing between the button and the text
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                          signInUpViewModel.hideWarning();
                        },
                        child: Text(
                          localizations.dontHaveAccount,
                          style: TextStyle(
                            color: Colors
                                .blue, // This makes the text look like a clickable link
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Google Signup Button

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomElevatedButton(
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                    icon: Image.asset('AppFiles/googleLogo.png', width: 24),
                    label: Text(localizations.signupWithGoogle),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
