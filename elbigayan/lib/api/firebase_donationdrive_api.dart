import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationDriveAPI{
  static final FirebaseFirestore db  = FirebaseFirestore.instance;

  Future<String> addDonationDrive(Map<String, dynamic> donationDrive) async {
    try {
      await db.collection("donationdrives").add(donationDrive);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  
  
}