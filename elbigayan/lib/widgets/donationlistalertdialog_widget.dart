import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbigayan/models/donation_model.dart';
import 'package:elbigayan/pages/organization/scan_code_page.dart';
import 'package:flutter/material.dart';

class DonationListAlertDialog extends StatelessWidget {
  final Stream<QuerySnapshot> donationStream;
  final String donationDriveId;

  const DonationListAlertDialog({Key? key, required this.donationStream, required this.donationDriveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: donationStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Donation Drives Found"),
          );
        }

        return AlertDialog(
          title: Row(
            children: [
              Expanded(child: Text("Link Donations")),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanCodePage()),
                  );
                },
                icon: Icon(Icons.qr_code),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                Donation donation = Donation.fromJson(doc.data() as Map<String, dynamic>);
                return GestureDetector(
                  onTap: () {
                    _linkDonationToDrive(context, donation.id!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      tileColor: Colors.blue[50],
                      title: Text(
                        "Donation by ${donation.name}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Future<void> _linkDonationToDrive(BuildContext context, String donationId) async {
  try {
    // Get the current donation list from the donation drive
    DocumentSnapshot donationDriveSnapshot = await FirebaseFirestore.instance.collection('donationdrives').doc(donationDriveId).get();
    List<dynamic> currentDonationList = donationDriveSnapshot.get('donationList') ?? [];

    // Add the new donation ID to the list
    currentDonationList.add(donationId);

    // Update the donation drive document with the modified donation list
    await FirebaseFirestore.instance.collection('donationdrives').doc(donationDriveId).update({
      'donationList': currentDonationList,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Donation linked successfully"),
      ),
    );
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to link donation: $error"),
      ),
    );
  }
}

}
