import 'package:flutter/material.dart';


class DonationPage extends StatefulWidget{
  const DonationPage({super.key});

  @override
  State<DonationPage> createState()=> _DonationPageState();
}

class _DonationPageState extends State<DonationPage>{

  @override
  Widget build (BuildContext context){
    const TextStyle defaultTextStyle= TextStyle(
      color:Colors.black,
      fontSize:20.0,
      fontWeight:FontWeight.bold,
    );
    return Scaffold(
      appBar:AppBar(
        title: const Text(
          "Donate",
          style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),
        ),
        backgroundColor:Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}