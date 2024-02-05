import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/services/AuthService.dart';

import '../../generated/l10n.dart';

class EditProfileScreen extends StatelessWidget {
  final String? initialUsername;
  final String? initialEmail;

  final TextEditingController _usernameController;
  final TextEditingController _emailController;
  final TextEditingController _bioController; // Add this line for the bio

  EditProfileScreen({
    this.initialUsername,
    this.initialEmail,
    String? initialBio, // Add this line for the bio
  })  : _usernameController = TextEditingController(text: initialUsername),
        _emailController = TextEditingController(text: initialEmail),
        _bioController = TextEditingController(
            text: initialBio); // Initialize the bio controller

  void _updateProfileAndBio(BuildContext context) async {
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
      if (currentUser != null) {
        // Update the profile
        await authService.updateUserProfile(
          currentUser.uid,
          _usernameController.text,
          _emailController.text,
          bio: _bioController.text, // Pass the bio to the update method
        );

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
        SnackBar(content: Text('Error updating profile and bio: $e')),
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
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: S.of(context).username),
            ),
            // TextFormField(
            //   controller: _emailController,
            //   readOnly: true,
            //   decoration: InputDecoration(
            //     labelText: S.of(context).email,
            //     hintText: S.of(context).cannotEditEmail,
            //   ),
            // ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(
                  labelText: 'Bio'), // Add this line for the bio
            ),
            ElevatedButton(
              onPressed: () => _updateProfileAndBio(context),
              child: Text(S.of(context).updateProfile),
            ),
          ],
        ),
      ),
    );
  }
}
