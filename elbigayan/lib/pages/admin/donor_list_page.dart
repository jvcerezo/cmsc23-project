import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorListPage extends StatelessWidget {
  const DonorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donors")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Donor').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> donorSnapshot) {
          if (donorSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!donorSnapshot.hasData || donorSnapshot.data!.docs.isEmpty) {
            return Center(child: Text("No donors found"));
          }

          final donors = donorSnapshot.data!.docs;

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (ctx, index) {
              final donor = donors[index];

              return ListTile(
                title: Text(donor['name']),
                subtitle: Text(donor['username']),
              );
            },
          );
        },
      ),
    );
  }
}
