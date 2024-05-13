import 'package:elbigayan/widgets/donationdrivelist_widget.dart';
import 'package:elbigayan/widgets/orgappdrawer_widget.dart';
import 'package:flutter/material.dart';

class DonationDrivePage extends StatefulWidget {
  const DonationDrivePage({super.key});

  @override
  State<DonationDrivePage> createState() => _DonationDrivePageState();
}

class _DonationDrivePageState extends State<DonationDrivePage> {
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
          "Donation Drives",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List of Donation Drives",
                style: defaultTextStyle,
              ),
              SizedBox(height: 20),
              DonationDriveList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Donation Drive'),
                content: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                    child: const Text('Add',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              );
            },
          );
        },
        label: const Text(
          'Add',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
