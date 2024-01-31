import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  final String? email;

  User(this.uid, this.email);
}

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> updateUserProfile(
      String uid, String username, String? email) async {
    await _firestore.collection('users').doc(uid).update({
      'username': username,
      // Update the email if necessary
      'email': email,
      // Do not include the password here
    });
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  User? get currentUser {
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<auth.UserCredential> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    final auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    auth.User? user = userCredential.user;

    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({'uid': user.uid, 'username': username, 'email': email});
    }

    return userCredential;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  // Fetch user profile from Firestore
  Future<Map<String, dynamic>?> fetchUserProfile(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<bool> validatePassword(String oldPassword) async {
    try {
      auth.User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // Re-authenticate the user with their old password
        final auth.AuthCredential credential =
            auth.EmailAuthProvider.credential(
                email: currentUser.email!, password: oldPassword);

        await currentUser.reauthenticateWithCredential(credential);

        // If re-authentication is successful, return true
        return true;
      } else {
        print('No user is currently signed in');
        // Handle the case where no user is signed in
        return false;
      }
    } catch (e) {
      print('Error validating password: $e');
      // If re-authentication fails, return false
      return false;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      auth.User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
        print('password changed successfuly');
      } else {
        print('no user is currently signed in');
      }
    } catch (e) {
      print('Error changing password: $e');
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      // Get the current user
      auth.User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        // Show a confirmation dialog
        bool confirmDelete = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Account Deletion'),
              content: Text('Are you sure you want to delete your account?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // User canceled
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // User confirmed
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmDelete == true) {
          // Delete the user account
          await currentUser.delete();

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account deleted successfully'),
              duration: Duration(seconds: 2),
            ),
          );

          // Redirect to the login screen or another screen after successful deletion
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        throw Exception("No user signed in");
      }
    } catch (e) {
      print('Error deleting account: $e');
      // Handle any errors during account deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting account: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      // You can show an error message or take appropriate actions
    }
  }
}
