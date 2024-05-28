import 'package:flutter/material.dart';
import 'donorAddressInputField_widget.dart';

class InputFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController weightController;
  final TextEditingController addressController;

  const InputFields({
    required this.nameController,
    required this.weightController,
    required this.addressController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter Donor Name',
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: weightController,
            decoration: InputDecoration(
              hintText: 'Enter Donation Weight(kg)',
              border: InputBorder.none,
            ),
          ),
        ),
        AddressInputField(controller: addressController),
      ],
    );
  }
}
