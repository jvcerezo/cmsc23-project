import 'package:elbigayan/models/donation_model.dart';
import 'package:elbigayan/pages/organization/orgview_donation_page.dart';
import 'package:flutter/material.dart';

class DonationList extends StatelessWidget {
  final List<String> donorNames;
  const DonationList({Key? key, required this.donorNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String jsonData =
        '[{"userID": 123, "id": "1", "category": "Clothes", "mode": "Pickup", "weight": 2.5, "deliveryTime": "Bukas", "imageUrl": "https://example.com/image1.jpg"}, {"userID": 456, "id": "2", "category": "Books", "mode": "Drop-off", "weight": 1.8, "deliveryTime": "Bukas", "imageUrl": "https://example.com/image2.jpg"}]';
    List<Donation> donations = Donation.fromJsonArray(jsonData);
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: donations.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  tileColor: Colors.blue[50],
                  title: Text(
                    "Donation by User ${donations[index].userID}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonationDetailsPage(donation: donations[index]),
                      ),                    
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
