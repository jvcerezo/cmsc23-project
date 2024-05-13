import 'package:flutter/material.dart';
import 'package:elbigayan/models/donation_model.dart';

class DonationDetailsPage extends StatelessWidget {
  final Donation donation;

  DonationDetailsPage({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
