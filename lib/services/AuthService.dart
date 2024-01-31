import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  final String? email;

  User(this.uid, this.email);
}

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
