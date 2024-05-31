import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbigayan/models/donation_drive_model.dart';
import 'package:elbigayan/pages/organization/orgview_donation_drive_details_page.dart';
import 'package:flutter/material.dart';

class DonationDriveList extends StatelessWidget {
  final Stream<QuerySnapshot> donationDriveStream;

  const DonationDriveList({Key? key, required this.donationDriveStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: donationDriveStream,
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

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, int index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            DonationDrive donationDrive = DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
            String donationDriveId = doc.id; // Get the document ID
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                tileColor: Colors.blue[50],
                title: Text(
                  donationDrive.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDriveDetailsPage(donationDrive: donationDrive, donationDriveId: donationDriveId),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
