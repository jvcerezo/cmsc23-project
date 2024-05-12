import 'package:flutter/material.dart';

class DonationList extends StatelessWidget {
  final List<String> donorNames;
  const DonationList({Key? key, required this.donorNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: donorNames.length,
            itemBuilder: (BuildContext context, int index) {
              String donorName = donorNames[index];
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
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
