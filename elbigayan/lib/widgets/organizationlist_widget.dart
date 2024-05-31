import 'package:flutter/material.dart';
import 'package:elbigayan/pages/Donor/org_details_page.dart';
import 'package:elbigayan/providers/organization_provider.dart';
import 'package:provider/provider.dart';

class OrganizationList extends StatelessWidget {
  const OrganizationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orgProvider = Provider.of<OrganizationProvider>(context);
    var organizations = orgProvider.approvedOrganizations;

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: organizations.length,
            itemBuilder: (BuildContext context, int index) {
              String organizationName = organizations[index]['orgName'];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    "$organizationName",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    // Set the current organization
                    orgProvider.setCurrentOrganization(organizations[index]);
                    // Navigate to organization details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrgInfo()),
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
