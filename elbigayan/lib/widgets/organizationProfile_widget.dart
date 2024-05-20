import 'package:flutter/material.dart';

class OrgProfile extends StatelessWidget {
  const OrgProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data
    String username = 'Organization';
    String address = 'Batong Maliit Los Banos';
    String contact = '123-456-7890';

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          username,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10), // Add some spacing
        Text('Address: $address'),
        const SizedBox(height: 10), // Add some spacing
        Text('Contact: $contact'),
      ],
    );
  }
}