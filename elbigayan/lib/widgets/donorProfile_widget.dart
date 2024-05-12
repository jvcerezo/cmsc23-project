import 'package:flutter/material.dart';

class DonorProfile extends StatelessWidget{
  const DonorProfile ({Key? key}) :super(key:key);

  @override
  Widget build(BuildContext context){
    return Column(
        children:[
          ClipOval(
            child:Container(
                height: 200,
                width: 200,
                color: Colors.grey[300],
                child: Center(
                  // image
                ),
              ),
            ),
              const SizedBox(height:20),
              Text(
                'AbiGonDouhKo_123',//username
                style:TextStyle(
                  fontSize:18,
                  fontWeight:FontWeight.bold,
                ),
              ),
            ],   
         );
        }
      }