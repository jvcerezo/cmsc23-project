import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDonationDriveAPI{
  static final FirebaseFirestore db  = FirebaseFirestore.instance;
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
      throw FirebaseAuthException(code: 'no-current-user', message: 'No user is currently signed in.');
    }
    return db.collection("donationdrives")
             .where('userId', isEqualTo: user.uid)
             .snapshots();
  }
}