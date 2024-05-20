import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/adminappdrawer_widget.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      drawer: const AdminAppDrawer(),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('View Organizations'),
            onTap: () => Navigator.pushNamed(context, '/organizations'),
          ),
          ListTile(
            title: Text('View Donations'),
            onTap: () => Navigator.pushNamed(context, '/donations'),
          ),
          ListTile(
            title: Text('View Donors'),
            onTap: () => Navigator.pushNamed(context, '/donors'),
          ),
        ],
      ),
    );
  }
}
