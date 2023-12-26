import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/CustomElevatedButton.dart';
import 'package:rafeq_app/Views/SignInUpViewModel.dart';
import 'package:rafeq_app/services/AuthService.dart';

class RegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signInUpViewModel = Provider.of<SignInUpViewModel>(context);
    var usernameController = TextEditingController(text: signInUpViewModel.username);
    var emailController = TextEditingController(text: signInUpViewModel.email);
    var passwordController = TextEditingController(text: signInUpViewModel.password);
    var passwordConfirmationController = TextEditingController(text: signInUpViewModel.passwordConfirmation);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'AppFiles/Newbackground.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'AppFiles/RfeeqLogo.png',
                        width: 60,
                        height: 60,
                      ),
                      const Text(
                        "رفيق",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),
                // Register Form
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20.0),
                  height: 500,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    )
                  ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Register',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C96F9),
                          )),
                      TextField(
                        controller: usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),
                      TextField(
                        controller: passwordConfirmationController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),
                      if (signInUpViewModel.isShowingWarning) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              signInUpViewModel.warningMessage,
                              style: TextStyle(fontSize: 12, color: Colors.red.withOpacity(0.8), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.warning, size: 12, color: Colors.red.withOpacity(0.8)),
                          ],
                        ),
                      ],
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: CustomElevatedButton(
                          onPressed: () {
                            signInUpViewModel.updateEmailAndPass(
                              usernameController.text,
                              emailController.text,
                              passwordController.text,
                              passwordConfirmationController.text,
                            );
                            signInUpViewModel.signUpWithEmailAndPassword(context);
                          },
                          label: const Text('Register'),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                          signInUpViewModel.hideWarning();
                        },
                        child: const Text(
                          "Already have an account? Login now",
                          style: TextStyle(
                            color: Colors.blue, // This makes the text look like a clickable link
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                // Google Signup Button
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () {
                        AuthService().signInWithGoogle();
                      },
                      icon: Image.asset('AppFiles/googleLogo.png', width: 24),
                      label: const Text('Sign up with Google'),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
