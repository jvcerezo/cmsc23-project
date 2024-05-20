import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthApi {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> setUserRole(String uid, String role, Map<String, dynamic> additionalData) async {
    await firestore.collection('users').doc(uid).set({
      'role': role,
      ...additionalData,
      if (role == 'Organization') 'status': 'pending'
    });
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
      return credential;  
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: ${e.code} ${e.message}');
      throw e;  
    } catch (e) {
      print('An unexpected error occurred: $e');
      rethrow; 
    }
  }

  Future<void> uploadProofOfLegitimacy(String uid, File proof) async {
    try {
      final ref = storage.ref().child('proofs/$uid');
      await ref.putFile(proof);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
