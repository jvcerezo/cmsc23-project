import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:flutter/material.dart';

class OrganizationList extends StatelessWidget {
  final List<String> OrganizationNames;
  const OrganizationList({Key? key, required this.OrganizationNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: OrganizationNames.length,
            itemBuilder: (BuildContext context, int index) {
              String OrganizationName = OrganizationNames[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    "$OrganizationName",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    // to donation page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> DonationPage()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}