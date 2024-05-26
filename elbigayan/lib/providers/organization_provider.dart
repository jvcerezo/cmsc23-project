import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/organization_model.dart';

class OrganizationProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Organization> _organizations = [];

  List<Organization> get organizations => _organizations;

  Future<void> fetchOrganizations() async {
    try {
      QuerySnapshot snapshot = await _db.collection('organizations').get();
      _organizations = snapshot.docs.map((doc) => Organization.fromMap(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addOrganization(Organization organization) async {
    try {
      await _db.collection('organizations').add(organization.toMap());
      _organizations.add(organization);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> approveOrganization(String id) async {
    try {
      await _db.collection('organizations').doc(id).update({'isApproved': true});
      int index = _organizations.indexWhere((org) => org.id == id);
      _organizations[index].isApproved = true;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
