import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import '../api/firebase_auth_api.dart' as firebase_api;
import '../models/user_model.dart'; 

class UserAuthProvider with ChangeNotifier {
  late firebase_api.FirebaseAuthApi authService; 
  late Stream<firebase_auth.User?> _uStream;
  String? _userRole;
  CustomUser? _customUser; 

  UserAuthProvider(){
    authService = firebase_api.FirebaseAuthApi();
    fetchAuthentication();
  }

  Stream<firebase_auth.User?> get userStream => _uStream;
  firebase_auth.User? get user => authService.getUser();
  String? get userRole => _userRole;
  CustomUser? get customUser => _customUser; 

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();
    _uStream.listen((user) async {
      if (user != null) {
        await fetchUserRole(user.uid); 
        await fetchCustomUser(user.uid); 
      } else {
        _userRole = null; 
        _customUser = null; 
      }
      notifyListeners();
    });
  }

  Future<void> fetchUserRole(String uid) async {
    _userRole = await authService.getUserRole(uid);
    notifyListeners();
  }

  Future<void> fetchCustomUser(String uid) async {
    _customUser = await authService.getCustomUser(uid);
    notifyListeners();
  }

  Future<void> signUp(String email, String password, String role, {required Map<String, dynamic> additionalData}) async {
    firebase_auth.UserCredential credential = await authService.signUp(email, password);
    if (credential.user != null) {
      String userId = credential.user!.uid;
      if (role == 'Organization' && additionalData['proofOfLegitimacy'] != null) {
        try {
          String downloadURL = await authService.uploadProofOfLegitimacy(userId, File(additionalData['proofOfLegitimacy']));
          additionalData['proofOfLegitimacy'] = downloadURL;
        } catch (e) {
          additionalData['proofOfLegitimacy'] = null;
        }
      }
      additionalData['isApproved'] = role == 'Organization' ? false : true;
      additionalData['isAcceptingDonations'] = role == 'Organization' ? false : true;
      await authService.setUserRole(userId, role, additionalData);
      notifyListeners();
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? message = await authService.signIn(email, password);
    if (message == null || message.isEmpty) {
      await fetchUserRole(firebase_api.FirebaseAuthApi.auth.currentUser!.uid);
      await fetchCustomUser(firebase_api.FirebaseAuthApi.auth.currentUser!.uid);
    }
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
