import 'package:flutter/material.dart';
import 'package:elbigayan/models/donation_model.dart';
import 'package:flutter/widgets.dart';

class DonationDetailsPage extends StatelessWidget {
  final Donation donation;

  DonationDetailsPage({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 40,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.blue[900],
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 24,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
            ),
          ),
        ],
        title: const Text(
          'Donation Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Text('User ID: ${donation.userID}'),
            Text('Category: ${donation.category}'),
            Text('Mode: ${donation.mode}'),
            Text('Weight: ${donation.weight}'),
            Text('Delivery Time: ${donation.deliveryTime}'),
            Text('Image URL: ${donation.imageUrl}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
