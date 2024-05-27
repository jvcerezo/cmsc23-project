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
    return Scaffold(
      appBar: AppBar(title: Text("Admin - Approve Organizations")),
      body: Consumer<OrganizationProvider>(
        builder: (context, organizationProvider, child) {
          if (organizationProvider.organizations.isEmpty) {
            return Center(child: Text("No pending organizations"));
          }

          return ListView.builder(
            itemCount: organizationProvider.organizations.length,
            itemBuilder: (ctx, index) {
              final organization = organizationProvider.organizations[index];
              return ListTile(
                title: Text(organization['name']),
                subtitle: Text(organization['about']),
                trailing: ElevatedButton(
                  onPressed: () async {
                    await organizationProvider.approveOrganization(organization['id']);
                  },
                  child: Text("Approve"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
