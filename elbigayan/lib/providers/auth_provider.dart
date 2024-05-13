import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthApi authService;
  late Stream<User?> _uStream;

  UserAuthProvider(){
    authService = FirebaseAuthApi();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication(){
    _uStream = authService.userSignedIn();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password);
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    String? message = await authService.signIn(email, password);
    notifyListeners();

    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}