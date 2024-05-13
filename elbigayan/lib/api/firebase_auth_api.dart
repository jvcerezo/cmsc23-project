import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthApi {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> setUserRole(String uid, String role) async {
    await firestore.collection('users').doc(uid).set({'role': role});
  }

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();
    return snapshot.get('role');
  }

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      String? role = await getUserRole(auth.currentUser!.uid);
      return role;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return e.message;
      } else if (e.code == 'invalid-credential') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;  // Return the credential upon successful sign-up
    } on FirebaseAuthException catch (e) {
      // Log the error for debugging
      print('Failed to sign up: ${e.code} ${e.message}');
      throw e;  // Rethrow the exception to allow further handling outside this method
    } catch (e) {
      // Handle any other exceptions that may occur
      print('An unexpected error occurred: $e');
      rethrow;  // Ensure the caller can handle unexpected errors appropriately
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}