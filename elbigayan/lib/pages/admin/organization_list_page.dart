import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationListPage extends StatelessWidget {
  const OrganizationListPage({super.key});

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
          "Organizations",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Organization').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> orgSnapshot) {
          if (orgSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!orgSnapshot.hasData || orgSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No organizations found"));
          }

          final organizations = orgSnapshot.data!.docs;

          return ListView.builder(
            itemCount: organizations.length,
            itemBuilder: (ctx, index) {
              final organization = organizations[index];

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    organization['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(organization['username']),
                  onTap: () {
                    // Navigate to organization detail or other related page
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
