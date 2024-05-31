import 'package:elbigayan/providers/donation_provider.dart';
import 'package:elbigayan/widgets/donationlist_widget.dart';
import 'package:elbigayan/widgets/donationlistalertdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:elbigayan/models/donation_drive_model.dart';
import 'package:elbigayan/pages/organization/scan_code_page.dart';
import 'package:provider/provider.dart';

class DonationDriveDetailsPage extends StatefulWidget {
  final DonationDrive donationDrive;

  DonationDriveDetailsPage({required this.donationDrive});

  @override
  State<DonationDriveDetailsPage> createState() => _DonationDriveDetailsPageState();
}

class _DonationDriveDetailsPageState extends State<DonationDriveDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DonationProvider>(context, listen: false).resetStream();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 40,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.blue[900],
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 24,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
            ),
          ),
        ],
        title: const Text(
          'Donation Drive Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.donationDrive.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 30),
            Text(
              "sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus et",
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: widget.donationDrive.donationList.length,
                itemBuilder: (context, index) {
                  String imageUrl = widget.donationDrive.donationList[index].images[0];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         showDialog(
      context: context,
      builder: (context) => DonationListWrapper(),
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


class DonationListWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap DonationDriveList with Consumer to rebuild when needed
    return Consumer<DonationProvider>(
      builder: (context, provider, _) {
        // Return DonationDriveList with the latest data
        return DonationListAlertDialog(donationStream: provider.donation);
      },
    );
  }
}