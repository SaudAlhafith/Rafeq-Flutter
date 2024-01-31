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

    if (_newPasswordController.text.isNotEmpty &&
        _newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Passwordsdonotmatch)),
      );
      return;
    }

    try {
      var authService = Provider.of<AuthService>(context, listen: false);
      var currentUser = authService.currentUser;
      if (currentUser != null) {
        // Update the profile
        await authService.updateUserProfile(
          currentUser.uid,
          _usernameController.text,
          _emailController.text,
        );

        // If a new password is entered, update it
        if (_newPasswordController.text.isNotEmpty) {
          await authService.changePassword(_newPasswordController.text);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).ProfileupdatedSuccessfully)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is currently signed in')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile and password: $e')),
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
        SnackBar(content: Text(S.of(context).ProfileupdatedSuccessfully)),
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
              readOnly: true,
              decoration: InputDecoration(
                labelText: S.of(context).email,
                hintText: S.of(context).cannotEditEmail,
              ),
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: S.of(context).NewPassword),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration:
                  InputDecoration(labelText: S.of(context).confirmNewPassword),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _updateProfileAndPassword(context),
              child: Text(S.of(context).updateProfile),
            ),
          ],
        ),
      ),
    );
  }
}
