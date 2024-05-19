import 'package:flutter/material.dart';

class SpecifyDonation extends StatelessWidget {
  final TextEditingController controller;

  const SpecifyDonation ({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Specify Donation',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
