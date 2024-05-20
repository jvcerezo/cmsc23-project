import 'package:elbigayan/widgets/donorSpecifyDonation_widget.dart';
import 'package:flutter/material.dart';

class DonationItem extends StatefulWidget {
  final Function(List<String>) donationItemCallback;

  const DonationItem({
    required this.donationItemCallback,
    Key? key,
  }) : super(key: key);

  @override
  _DonationItemState createState() => _DonationItemState();
}

class _DonationItemState extends State<DonationItem> {
  // Map to store donation items and their selected state
  static final Map<String, bool> _donationItems = {
    "Food": true,
    "Clothes": false,
    "Cash": false,
    "Necessities": false,
    "Others": false,
  };

  // to show or hide the specify donation text field
  bool _showSpecifyDonation = false;
  final TextEditingController _specifyDonationController = TextEditingController();

  // Get a list of currently selected donation items
  List<String> get _selectedDonationItems => _donationItems.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Center(
          child: Text(
            "Donation Item",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: _donationItems.keys.map((donationItem) {
            return CheckboxListTile(
              title: Text(donationItem),
              value: _donationItems[donationItem],
              onChanged: (bool? value) {
                setState(() {
                  _donationItems[donationItem] = value!;

                  //Check if others is selected
                  if(donationItem=="Others"){
                    _showSpecifyDonation=value;
                  }
                  widget.donationItemCallback(_selectedDonationItems);
                });
              },
            );
          }).toList(),
        ),
        if(_showSpecifyDonation)
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SpecifyDonation(controller: _specifyDonationController),
        ),
      ],
    );
  }
}
