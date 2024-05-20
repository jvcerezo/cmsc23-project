import 'package:flutter/material.dart';

class DonorProfile extends StatelessWidget{
  const DonorProfile ({Key? key}) :super(key:key);

  @override
  Widget build(BuildContext context){

    //Dummy data
    String username ='AbiGonDouhko_123';
    String name = 'Abigail Nadua';
    String address = 'Batong Maliit Los Banos';
    String contact= '123-456-7890';

    return Column(
        children:[
          ClipOval(
            child:Container(
                height: 300,
                width: 300,
                color: Colors.blue[100],
                child: Center(
                  // image
                ),
              ),
            ),
            const SizedBox(height:20),

            Text(
              username,
              style:TextStyle(
                fontSize:18,
                fontWeight:FontWeight.bold,
              ),
            ),
            SizedBox(height:20),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue[50],
              ),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'Name:',
                    style:TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: name,//dummy
                    enabled:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),    

                SizedBox(height: 10.0),            

                  Text(
                    'Address:',
                    style:TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: address,//dummy
                    enabled:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ), 

                SizedBox(height: 10.0), 

                  Text(
                    'Contact #:',
                    style:TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    initialValue: contact,//dummy
                    enabled:false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ), 

                ],
              ),
            ),
          ],   
        );
      }
    }