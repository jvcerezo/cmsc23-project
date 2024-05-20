import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/organizationlist_widget.dart';
import 'package:elbigayan/widgets/donorappdrawer_widget.dart';

class DonorHomePage extends StatefulWidget{
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage>{
  //Dummy data  

  final List <String> orgNames =[
    'Batong Malake Community Pantry',
    'Madre de amor Hospice Foundation',
    'Community Help Alternatives Inc',
    'El danda Jeepney Drivers',
    'Piston Jeepney Drivers',
    'UPLB Learning Resource Center',
    'UPLB Red Cross Youth',
    'UPLB Vendors',
    'UPLB BARKada && CATropa'
  ];

  @override
  Widget build(BuildContext context){
    const TextStyle defaultTextStyle= TextStyle(
      color:Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      drawer: const DonorAppDrawer(),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),
        ),
        backgroundColor:Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin:const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              const Text(
                "List of Organizations",
                style:defaultTextStyle,
              ),
              const SizedBox(height:20),
              OrganizationList(OrganizationNames:orgNames)
            ],
          ),
        ),
      ),
    );
  }
}