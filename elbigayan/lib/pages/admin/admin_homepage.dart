import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/adminappdrawer_widget.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
          'Admin Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AdminAppDrawer(),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              ListTile(
                title: Text('View Organizations', style: defaultTextStyle),
                onTap: () => Navigator.pushNamed(context, '/organizations-list'),
              ),
              ListTile(
                title: Text('View Donors', style: defaultTextStyle),
                onTap: () => Navigator.pushNamed(context, '/donors-list'),
              ),
              ListTile(
                title: Text('Approve Organizations', style: defaultTextStyle),
                onTap: () => Navigator.pushNamed(context, '/approve-organization'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
