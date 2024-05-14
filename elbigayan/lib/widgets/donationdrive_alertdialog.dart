import 'package:flutter/material.dart';

class AddDonationDrive extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  // List<Donation> donationList;
  AddDonationDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Donation Drive', style: TextStyle(fontWeight: FontWeight.bold),),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ID:', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ), 
            const SizedBox(height: 20,),
            const Text(
              'Title of Donation Drive:', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
          child: const Text('Add',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
