import 'package:flutter/material.dart';
import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:elbigayan/providers/organization_provider.dart';
import 'package:provider/provider.dart';

class OrgInfo extends StatelessWidget {
  const OrgInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final organizationProvider = Provider.of<OrganizationProvider>(context);
    final organization = organizationProvider.currentOrganization;

    if (organization == null) {
      return Center(child: CircularProgressIndicator());
    }
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
              organization['orgName'] ?? 'Organization',
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
                  Text(
                    'Contact: ${organization['contact'] ?? 'Not available'}'
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(

                    //   ),
                    // ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'About: ${organization['aboutOrg'] ?? 'Not available'}'
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
               //
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 15),
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
