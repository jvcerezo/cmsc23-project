import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/organization_provider.dart';

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrganizationProvider>(context, listen: false).fetchPendingOrganizations();
  }

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
          "Approve Organizations",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<OrganizationProvider>(
        builder: (context, organizationProvider, child) {
          if (organizationProvider.organizations.isEmpty) {
            return const Center(child: Text("No pending organizations"));
          }

          final organizations = organizationProvider.organizations;

          return ListView.builder(
            itemCount: organizations.length,
            itemBuilder: (ctx, index) {
              final organization = organizations[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    organization['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(organization['aboutOrg']),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => OrganizationDetailsDialog(
                        organization: organization,
                        onApprove: () async {
                          await organizationProvider.approveOrganization(organization['id']);
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrganizationDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> organization;
  final VoidCallback onApprove;

  const OrganizationDetailsDialog({
    required this.organization,
    required this.onApprove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(organization['name']),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About: ${organization['aboutOrg']}"),
            const SizedBox(height: 10),
            if (organization['proofOfLegitimacy'] != null && organization['proofOfLegitimacy'].isNotEmpty)
              Column(
                children: [
                  Text("Proof of Legitimacy:"),
                  const SizedBox(height: 10),
                  Image.network(
                    organization['proofOfLegitimacy'],
                    errorBuilder: (context, error, stackTrace) {
                      return const Text("Image failed to load.");
                    },
                  ),
                ],
              )
            else
              const Text("No proof of legitimacy provided."),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: onApprove,
          child: const Text("Approve"),
        ),
      ],
    );
  }
}
