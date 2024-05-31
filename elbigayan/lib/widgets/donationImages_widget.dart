import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbigayan/providers/donation_provider.dart';

class DonationImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donationProvider = Provider.of<DonationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Donation Images",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload Image",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  donationProvider.pickAndUploadImage();
                },
                child: Text("Upload"),
              ),
              SizedBox(height: 10),
              if (donationProvider.uploadedImageUrls.isEmpty)
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "No images uploaded",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      crossAxisSpacing: 8.0, 
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: donationProvider.uploadedImageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(donationProvider.uploadedImageUrls[index]),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
