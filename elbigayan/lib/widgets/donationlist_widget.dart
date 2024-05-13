import 'package:elbigayan/widgets/donationtile_widget.dart';
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
              return DonationTile(donorName: donorName);
            },
          ),
        ],
      ),
    );
  }
}
