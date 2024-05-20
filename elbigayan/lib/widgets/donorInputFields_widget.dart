import 'package:flutter/material.dart';

class InputFields extends StatefulWidget{
  const InputFields ({Key? key}) : super(key:key);

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields>{
 TextEditingController _nameController = TextEditingController();
 TextEditingController _weightController = TextEditingController();

 @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color:Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter Donor Name',
              border:InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color:Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _weightController,
            decoration: InputDecoration(
              hintText: 'Enter Donation Weight(kg)',
              border:InputBorder.none,
            ),
          ),
        ),        
      ],
    ); 
  }
}

