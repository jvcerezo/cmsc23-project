import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorListPage extends StatelessWidget {
  const DonorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle defaultTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donors",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Donor').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> donorSnapshot) {
          if (donorSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!donorSnapshot.hasData || donorSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No donors found"));
          }

          final donors = donorSnapshot.data!.docs;

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (ctx, index) {
              final donor = donors[index];

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    donor['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(donor['username']),
                  onTap: () {
                    // Handle tap if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
