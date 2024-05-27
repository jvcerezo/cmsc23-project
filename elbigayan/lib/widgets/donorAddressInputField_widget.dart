import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressInputField extends StatefulWidget {
  final TextEditingController controller;

  const AddressInputField({Key? key, required this.controller}) : super(key: key);

    @override
  _AddressInputFieldState createState() => _AddressInputFieldState();
}
class _AddressInputFieldState extends State<AddressInputField> {
  //maanage the additional address input field dynamic
  List<TextEditingController> additionalControllers=[];

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
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'Enter Address',
              border: InputBorder.none,
            ),
          ),
        ),
        ElevatedButton(
          onPressed:() {
            setState(() {
              additionalControllers.add(TextEditingController());
            });
          },
          child:
          Text(
            '+Add Address'
          ),
        ),
          ...additionalControllers.asMap().entries.map((entry){
            int index=entry.key;
            TextEditingController controller =entry.value;
            return Row(
              children: [
                Expanded(
                  child:Container(
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
                      hintText: 'Enter Additional Address',
                      border: InputBorder.none, 
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    additionalControllers.removeAt(index);
                  });
                },
              ),
              ],
            );
          }).toList(),
      ],
    );
  }
}

