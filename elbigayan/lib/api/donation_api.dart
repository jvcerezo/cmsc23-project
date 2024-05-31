import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection("donations").add(donation);
      return "Donation added successfully";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Stream<QuerySnapshot> getDonationsByOrganization(String organizationId) {
    return db
        .collection("donations")
        .where("organizationId", isEqualTo: organizationId)
        .snapshots();
  }
}
