import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/organization_provider.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({Key? key}) : super(key: key);

  @override
  _OrgProfileState createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrganizationProvider>(context, listen: false).fetchCurrentOrganization();
  }

  @override
  Widget build(BuildContext context) {
    final organizationProvider = Provider.of<OrganizationProvider>(context);
    final organization = organizationProvider.currentOrganization;

    if (organization == null) {
      return Center(child: CircularProgressIndicator());
    }

    bool isAcceptingDonations = organization['isAcceptingDonations'] ?? false;
    Color? buttonColor = isAcceptingDonations ? Colors.blue[500] : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              organization['orgName'] ?? 'Organization',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                bool newStatus = !isAcceptingDonations;
                organizationProvider.updateAcceptingDonations(newStatus);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: Text(
                isAcceptingDonations ? 'Online' : 'Offline',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Address: ${organization['address'] ?? 'Not available'}'),
        const SizedBox(height: 10),
        Text('Contact: ${organization['contact'] ?? 'Not available'}'),
        const SizedBox(height: 20),
        Text('About: ${organization['aboutOrg'] ?? 'Not available'}'),
      ],
    );
  }
}
