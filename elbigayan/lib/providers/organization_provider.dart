import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _organizations = [];

  List<Map<String, dynamic>> get organizations => _organizations;

  Future<void> fetchPendingOrganizations() async {
  try {
    QuerySnapshot snapshot = await _db.collection('users')
        .where('role', isEqualTo: 'Organization')
        .where('isApproved', isEqualTo: false) // Ensure this is checking for boolean false
        .get();
    _organizations = snapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>
    }).toList();
    print(_organizations); // Add this to check data
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
}
