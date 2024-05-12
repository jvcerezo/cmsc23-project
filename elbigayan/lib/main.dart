import 'package:elbigayan/pages/Donor/donorhome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'ELBIgayan',
      initialRoute: '/',
      routes: {
        '/': (context) => DonorHomePage(), 
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}