import 'package:elbigayan/providers/donationdrive_provider.dart';
import 'package:elbigayan/widgets/donationdrive_alertdialog.dart';
import 'package:elbigayan/widgets/donationdrivelist_widget.dart';
import 'package:elbigayan/widgets/orgappdrawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDrivePage extends StatefulWidget {
  const DonationDrivePage({super.key});

  @override
  State<DonationDrivePage> createState() => _DonationDrivePageState();
}

class _DonationDrivePageState extends State<DonationDrivePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DonationDriveListProvider>(context, listen: false).resetStream();
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List of Donation Drives",
                style: defaultTextStyle,
              ),
              SizedBox(height: 20),
              DonationDriveListWrapper()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddDonationDrive();
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

class DonationDriveListWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap DonationDriveList with Consumer to rebuild when needed
    return Consumer<DonationDriveListProvider>(
      builder: (context, provider, _) {
        // Return DonationDriveList with the latest data
        return DonationDriveList(donationDriveStream: provider.donationdrive);
      },
    );
  }
}
