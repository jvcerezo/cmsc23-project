
import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:flutter/material.dart';

class OrgInfo extends StatefulWidget {
  const OrgInfo({super.key});

  @override
  State<OrgInfo> createState() => _OrgInfoState();
}

class _OrgInfoState extends State<OrgInfo> {
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
          "Org Information",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:Container(
        margin:const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=> DonationPage()),
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
      ),
    );
  }
}