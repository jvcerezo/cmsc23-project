import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/donorappdrawer_widget.dart';

class DonorProfilePage extends StatefulWidget{
  const DonorProfilePage({super.key});

  @override
  State<DonorProfilePage> createState()=> _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage>{

  @override
  Widget build (BuildContext context){
    const TextStyle defaultTextStyle= TextStyle(
      color:Colors.black,
      fontSize:20.0,
      fontWeight:FontWeight.bold,
    );
    return Scaffold(
      drawer: const DonorAppDrawer(),
      appBar:AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),
        ),
        backgroundColor:Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:Container(
        margin:const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[

            ],
          ),
        ),
      ),
    );
  }
}