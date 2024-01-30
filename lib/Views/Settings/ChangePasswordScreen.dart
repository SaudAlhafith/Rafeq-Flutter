import 'package:flutter/material.dart';
import 'package:rafeq_app/services/AuthService.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService authService = AuthService(); // Your authentication service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Old Password'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic to validate and change the password
                changePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validate old password
    bool isOldPasswordValid = await authService.validatePassword(oldPassword);

    if (!isOldPasswordValid) {
      // Show an error message or alert for invalid old password
      print('Invalid old password');
      return;
    }

    // Add additional validation logic if needed (e.g., password strength)

    // Validate new password and confirm password
    if (newPassword != confirmPassword) {
      // Show an error message or alert
      print('Password and confirm password do not match');
      return;
    }

    // Call your authentication service to change the password
    await authService.changePassword(newPassword);

    // Show a success message or navigate back
    Navigator.pop(context); // Navigate back to the previous screen
    // Alternatively, you can show a snackbar or dialog indicating success
  }
}
