import 'package:elbigayan/widgets/donationlist_widget.dart';
import 'package:elbigayan/widgets/orgappdrawer_widget.dart';
import 'package:flutter/material.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  // Dummy data // TODO: Model for donation
  final List<String> names = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Emily Davis',
    'Michael Wilson',
    'Sarah Martinez',
    'David Anderson',
    'Laura Taylor',
    'Kevin Clark',
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Emily Davis',
    'Michael Wilson',
    'Sarah Martinez',
    'David Anderson',
    'Laura Taylor',
    'Kevin Clark',
  ];

  @override
  Widget build(BuildContext context) {
    const TextStyle defaultTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      drawer: const OrganizationAppDrawer(),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "List of Donations",
                style: defaultTextStyle,
              ),
              const SizedBox(height: 20),
              DonationList(donorNames: names),
            ],
          ),
        ),
      ),
    );
  }
}
