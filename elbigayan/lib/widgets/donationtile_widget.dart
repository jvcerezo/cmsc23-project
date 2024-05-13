import 'package:flutter/material.dart';

class DonationTile extends StatelessWidget {
  final String donorName;
  const DonationTile({Key? key, required this.donorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        tileColor: Colors.blue[50],
        title: Text(
          "Donation by $donorName",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onTap: () {
          // Handle onTap event if needed
        },
      ),
    );
  }
}
