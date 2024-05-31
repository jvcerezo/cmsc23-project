import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbigayan/models/donation_model.dart';
import 'package:elbigayan/pages/organization/orgview_donation_page.dart';
import 'package:flutter/material.dart';

class DonationList extends StatelessWidget {
  final Stream<QuerySnapshot> donationStream;

  const DonationList({Key? key, required this.donationStream}) : super(key: key);

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
            child: Text("No Donations Found"),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, int index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Donation donation = Donation.fromJson(doc.data() as Map<String, dynamic>);
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                tileColor: Colors.blue[50],
                title: Text(
                  donation.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDetailsPage(donation: donation),
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
