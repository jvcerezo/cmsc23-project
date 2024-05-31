import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbigayan/api/firebase_donationdrive_api.dart';
import 'package:flutter/material.dart';

class DonationDriveListProvider with ChangeNotifier {
  FirebaseDonationDriveAPI firebaseService = FirebaseDonationDriveAPI();
  late Stream<QuerySnapshot> _donationdrivesStream;

  DonationDriveListProvider() {
    fetchDonationDrives();
  }

  Stream<QuerySnapshot> get donationdrive => _donationdrivesStream;

  void fetchDonationDrives() {
    // _donationdrivesStream = firebaseService.getAllDonationDrives();
    _donationdrivesStream = firebaseService.getUserDonationDrives();
    notifyListeners(); // Notify listeners after setting the stream
  }

  void resetStream() {
    fetchDonationDrives(); // Re-fetch the donation drives to reset the stream
  }
}
