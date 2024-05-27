import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationListPage extends StatelessWidget {
  const OrganizationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Organizations")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Organization').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> orgSnapshot) {
          if (orgSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!orgSnapshot.hasData || orgSnapshot.data!.docs.isEmpty) {
            return Center(child: Text("No organizations found"));
          }

          final organizations = orgSnapshot.data!.docs;

          return ListView.builder(
            itemCount: organizations.length,
            itemBuilder: (ctx, index) {
              final organization = organizations[index];

              return ListTile(
                title: Text(organization['name']),
                subtitle: Text(organization['username']),
              );
            },
          );
        },
      ),
    );
  }
}
