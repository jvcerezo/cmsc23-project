import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:flutter/material.dart';

class OrgInfo extends StatefulWidget {
  const OrgInfo({Key? key}) : super(key: key);

  @override
  State<OrgInfo> createState() => _OrgInfoState();
}

class _OrgInfoState extends State<OrgInfo> {
  // Dummy data
  String name = 'UPLB YSES-COSS-ACSS';
  String contact = '09123456789';
  String address = 'Batong Maliit Los Banos';
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    Color? buttonColor = isOnline ? Colors.blue[500] : Colors.grey;

    const TextStyle defaultTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Org Information",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue[50],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact #',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: contact, // Dummy
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: address, // Dummy
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: isOnline.toString(), // Dummy
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text(
                  'Donate',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
