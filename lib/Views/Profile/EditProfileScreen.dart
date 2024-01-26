import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/services/AuthService.dart';

import '../../generated/l10n.dart';

class EditProfileScreen extends StatelessWidget {
  final String? initialUsername;
  final String? initialEmail;

  final TextEditingController _usernameController;
  final TextEditingController _emailController;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  EditProfileScreen({this.initialUsername, this.initialEmail})
      : _usernameController = TextEditingController(text: initialUsername),
        _emailController = TextEditingController(text: initialEmail);

  void _updateProfileAndPassword(BuildContext context) async {
    // Basic validation example
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username cannot be empty')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      var authService = Provider.of<AuthService>(context, listen: false);
      // Assuming you have a method to update the password in AuthService
      await authService.updateUserPassword(_newPasswordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating password: $e')),
      );
    }
  }

  void _updateProfile(BuildContext context) async {
    // Basic validation example
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username cannot be empty')),
      );
      return;
    }

    try {
      var authService = Provider.of<AuthService>(context, listen: false);
      var currentUser = authService.currentUser;
      await authService.updateUserProfile(
        currentUser!.uid,
        _usernameController.text,
        _emailController.text,
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      // Optionally, navigate back or update the UI
    } catch (e) {
      // Handle any errors here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: S.of(context).username),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: S.of(context).email),
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _updateProfileAndPassword(context),
              child: Text('Update Profile and Password'),
            ),
          ],
        ),
      ),
    );
  }
}
