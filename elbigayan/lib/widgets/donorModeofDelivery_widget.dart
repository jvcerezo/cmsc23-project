import 'package:flutter/material.dart';

class ModeofDelivery extends StatefulWidget {
  const ModeofDelivery({Key? key}) : super(key: key);

  @override
  _ModeofDeliveryState createState() => _ModeofDeliveryState();
}

class _ModeofDeliveryState extends State<ModeofDelivery> {
  static final List<String> _dropdownOptions = [
    "Pick-up",
    "Drop-off",
  ];

  String _dropdownValue = _dropdownOptions.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Text(
          "Mode of Delivery",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          validator: (val) {
            if (_dropdownValue == _dropdownOptions[0]) return "Choose your Superpower";
            return null;
          },
          value: _dropdownValue,
          items: _dropdownOptions.map((dropdownOptions) {
            return DropdownMenuItem<String>(
              child: Text(dropdownOptions),
              value: dropdownOptions,
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _dropdownValue = val!;
            });
          },
        )
      ],
    );
  }
}
