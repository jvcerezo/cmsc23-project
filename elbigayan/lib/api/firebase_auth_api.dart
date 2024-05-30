import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart'; // Import the user model

class FirebaseAuthApi {
  static final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> setUserRole(String uid, String role, Map<String, dynamic> additionalData) async {
    await firestore.collection('users').doc(uid).set({
      'id': uid,
      'role': role,
      ...additionalData,
      if (role == 'Organization') 'isApproved': false
    });
  }

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return snapshot.get('role');
    } else {
      return null;
    }
  }

  Future<CustomUser?> getCustomUser(String uid) async {
    DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return CustomUser.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  firebase_auth.User? getUser() {
    return auth.currentUser;
  }

  Stream<firebase_auth.User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      String? role = await getUserRole(auth.currentUser!.uid);
      return role;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return e.message;
      } else if (e.code == 'invalid-credential') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  Future<firebase_auth.UserCredential> signUp(String email, String password) async {
    try {
      firebase_auth.UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;  
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Failed to sign up: ${e.code} ${e.message}');
      throw e;  
    } catch (e) {
      print('An unexpected error occurred: $e');
      rethrow; 
    }
  }

  Future<String> uploadProofOfLegitimacy(String uid, File proof) async {
    try {
      final ref = storage.ref().child('proofs/$uid/${proof.path.split('/').last}');
      await ref.putFile(proof);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
