import 'package:flutter/material.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({Key? key}) : super(key: key);

  @override
  _OrgProfileState createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  // Dummy data
  String username = 'Organization';
  String address = 'Batong Maliit Los Banos';
  String contact = '123-456-7890';
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    Color? buttonColor = isOnline ? Colors.blue[500] : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              username,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isOnline = !isOnline;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: Text(
                isOnline ? 'Online' : 'Offline',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Address: $address'),
        const SizedBox(height: 10),
        Text('Contact: $contact'),
        const SizedBox(height: 20),
        Text(
          "sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus et",
        ),
      ],
    );
  }
}
