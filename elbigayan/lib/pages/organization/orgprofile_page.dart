import 'package:elbigayan/widgets/organizationProfile_widget.dart';
import 'package:elbigayan/widgets/orgappdrawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:elbigayan/widgets/donorappdrawer_widget.dart';
import 'package:elbigayan/widgets/donorProfile_widget.dart';


class OrgProfilePage extends StatefulWidget{
  const OrgProfilePage({super.key});

  @override
  State<OrgProfilePage> createState()=> _OrgProfilePagePageState();
}

class _OrgProfilePagePageState extends State<OrgProfilePage>{

  @override
  Widget build (BuildContext context){
    const TextStyle defaultTextStyle= TextStyle(
      color:Colors.black,
      fontSize:20.0,
      fontWeight:FontWeight.bold,
    );
    return Scaffold(
      drawer: const OrganizationAppDrawer(),
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
              OrgProfile(),
            ],
          ),
        ),
      ),
    );
  }
}