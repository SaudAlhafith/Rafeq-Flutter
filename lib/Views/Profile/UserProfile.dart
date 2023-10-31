import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/services/AuthService.dart';

class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    var user = Provider.of<User?>(context);

    return SafeArea(
      child: Column(
        children: [
          Text(user?.uid.toString() ?? "No User"),
          ElevatedButton(
            onPressed: () {
              authService.logout();
            },
            child: const Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
