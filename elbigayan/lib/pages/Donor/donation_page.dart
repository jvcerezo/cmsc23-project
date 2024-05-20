import 'package:elbigayan/widgets/donorInputFields_widget.dart';
import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/donorDonationItem_widget.dart';
import 'package:elbigayan/widgets/donorModeofDelivery_widget.dart';
import 'package:elbigayan/widgets/donorDateTimeInputFields_widget.dart';

class DonationPage extends StatefulWidget{
  const DonationPage({super.key});

  @override
  State<DonationPage> createState()=> _DonationPageState();
}

class _DonationPageState extends State<DonationPage>{
  List<String> donationItem =[];

  void updateDonationItems(List<String> items){
    setState((){
      donationItem=items;
    });
  }

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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              const Center(
              child: Text(
                "Name of the Organization",
                style:defaultTextStyle,
              ),
              ),
              DonationItem(donationItemCallback:updateDonationItems),
              InputFields(),
              ModeofDelivery(),
              DateTimeInputs(),
            ],
          ),
        ),
      ),
    );
  }
}