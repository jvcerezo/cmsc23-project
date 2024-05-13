import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthApi authService;
  late Stream<User?> _uStream;
  String? _userRole;

  UserAuthProvider(){
    authService = FirebaseAuthApi();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();
  String? get userRole => _userRole;

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();
    _uStream.listen((user) {
      if (user != null) {
        fetchUserRole(user.uid); // Fetch user role when auth state changes
      } else {
        _userRole = null; // Reset role to null when user signs out
      }
      notifyListeners();
    });
  }

  Future<void> fetchUserRole(String uid) async {
    _userRole = await authService.getUserRole(uid);
    notifyListeners();
  }

  Future<void> signUp(String email, String password, String role) async {
    UserCredential credential = await authService.signUp(email, password);
    if (credential.user != null) {
      await authService.setUserRole(credential.user!.uid, role);
      notifyListeners();
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? message = await authService.signIn(email, password);
    if (message == null || message.isEmpty) {
      await fetchUserRole(FirebaseAuthApi.auth.currentUser!.uid);
    }
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}

