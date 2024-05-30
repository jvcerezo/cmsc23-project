import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbigayan/providers/donation_provider.dart';
import 'package:elbigayan/widgets/donorDateTimeInputFields_widget.dart';
import 'package:elbigayan/widgets/donorInputFields_widget.dart';
import 'package:elbigayan/widgets/donorAddressInputField_widget.dart';
import 'package:elbigayan/widgets/donorModeofDelivery_widget.dart';
import 'package:elbigayan/widgets/donorDonationItem_widget.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final donationProvider = Provider.of<DonationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Name of the Organization",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DonationItem(donationItemCallback: donationProvider.updateDonationItems),
              InputFields(
                nameController: donationProvider.nameController,
                weightController: donationProvider.weightController,
                addressController: donationProvider.addressController,
              ),
              ModeofDelivery(),
              DateTimeInputs(
                onDateSelected: donationProvider.updateDate,
                onTimeSelected: donationProvider.updateTime,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await donationProvider.submitDonation(context);
                  },
                  child: const Text('Submit Donation'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
