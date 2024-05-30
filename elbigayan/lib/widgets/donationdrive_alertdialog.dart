import 'package:elbigayan/api/firebase_auth_api.dart';
import 'package:elbigayan/api/firebase_donationdrive_api.dart';
import 'package:elbigayan/models/donation_drive_model.dart'; 
import 'package:flutter/material.dart';

class AddDonationDrive extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final FirebaseDonationDriveAPI firebaseApi = FirebaseDonationDriveAPI();
  final FirebaseAuthApi firebaseAuthApi = FirebaseAuthApi();

  AddDonationDrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Donation Drive',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title of Donation Drive:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            String title = _titleController.text;

            // Get the current user's UID
            String? userId = firebaseAuthApi.getCurrentUserId();
            if (userId == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("User is not signed in."),
              ));
              return;
            }

            DonationDrive newDrive = DonationDrive(
              title: title,
              userId: userId,
              donationList: [],
            );

            String result = await firebaseApi.addDonationDrive(newDrive.toJson());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
          child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
