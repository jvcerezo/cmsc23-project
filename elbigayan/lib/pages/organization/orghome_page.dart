import 'package:elbigayan/providers/donation_provider.dart';
import 'package:elbigayan/widgets/donationlist_widget.dart';
import 'package:elbigayan/widgets/orgappdrawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DonationProvider>(context, listen: false).resetStream();
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
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin:  EdgeInsets.fromLTRB(30, 30, 30, 0),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "List of Donations",
                style: defaultTextStyle,
              ),
              const SizedBox(height: 20),
              DonationListWrapper(),
            ],
          ),
        ),
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
        return DonationList(donationStream: provider.donation);
      },
    );
  }
}

