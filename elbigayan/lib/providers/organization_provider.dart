import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrganizationProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _organizations = [];
  List<Map<String, dynamic>> _approvedOrganizations = [];
  Map<String, dynamic>? _currentOrganization;

  List<Map<String, dynamic>> get organizations => _organizations;
  List<Map<String, dynamic>> get approvedOrganizations => _approvedOrganizations;
  Map<String, dynamic>? get currentOrganization => _currentOrganization;

  Future<void> fetchPendingOrganizations() async {
    try {
      QuerySnapshot snapshot = await _db.collection('users')
          .where('role', isEqualTo: 'Organization')
          .where('isApproved', isEqualTo: false)
          .get();
      _organizations = snapshot.docs.map((doc) => {
        'id': doc.id,
        'orgName': doc['orgName'],
        ...doc.data() as Map<String, dynamic>
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchApprovedOrganizations() async {
    try {
      QuerySnapshot snapshot = await _db.collection('users')
          .where('role', isEqualTo: 'Organization')
          .where('isApproved', isEqualTo: true)
          .get();
      _approvedOrganizations = snapshot.docs.map((doc) => {
        'id': doc.id,
        'orgName': doc['orgName'],
        ...doc.data() as Map<String, dynamic>
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> approveOrganization(String id) async {
    try {
      await _db.collection('users').doc(id).update({'isApproved': true});
      _organizations.removeWhere((org) => org['id'] == id);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchCurrentOrganization() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
        _currentOrganization = {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>
        };
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateAcceptingDonations(bool isAccepting) async {
    try {
      User? user = _auth.currentUser;
      if (user != null && _currentOrganization != null) {
        await _db.collection('users').doc(user.uid).update({'isAcceptingDonations': isAccepting});
        _currentOrganization!['isAcceptingDonations'] = isAccepting;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void setCurrentOrganization(Map<String, dynamic> organization) {
    _currentOrganization = organization;
    notifyListeners();
  }
}
