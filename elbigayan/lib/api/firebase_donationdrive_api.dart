import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbigayan/models/donation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDonationDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> addDonationDrive(Map<String, dynamic> donationDrive) async {
    try {
      await db.collection("donationdrives").add(donationDrive);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonationDrives() {
    return db.collection("donationdrives").snapshots();
  }

  Stream<QuerySnapshot> getUserDonationDrives() {
    User? user = auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
          code: 'no-current-user', message: 'No user is currently signed in.');
    }
    return db
        .collection("donationdrives")
        .where('userId', isEqualTo: user.uid)
        .snapshots();
  }

  Future<void> addDonationToDrive(
      String donationDriveId, Donation donation) async {
    try {
      // Get a reference to the donation drive document
      DocumentReference driveRef = FirebaseFirestore.instance
          .collection('donationdrives')
          .doc(donationDriveId);

      // Get the current donation list from the document
      DocumentSnapshot driveSnapshot = await driveRef.get();
      List<dynamic> currentDonations =
          (driveSnapshot.data() as Map<String, dynamic>)['donationList'] ?? [];

      // Add the new donation to the current list
      currentDonations.add(donation.toJson());

      // Update the donation list in the document
      await driveRef.update({'donationList': currentDonations});

      print(
          'Donation added successfully to the donation drive with ID: $donationDriveId');
    } catch (error) {
      print('Error adding donation to donation drive: $error');
    }
  }
}
