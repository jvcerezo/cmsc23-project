import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String organizationId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('donations')
              .where('organizationId', isEqualTo: organizationId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            if (data.size == 0) {
              return const Center(child: Text("No donations found for this organization"));
            }

            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                var donation = data.docs[index];
                return ListTile(
                  title: Text(donation['name']),
                  subtitle: Text('Weight: ${donation['weight']} kg\nItems: ${donation['items'].join(', ')}\nDate: ${donation['time']} : ${donation['date']} : ${donation['address']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
