import 'package:elbigayan/pages/organization/orgdonation_drive_page.dart';
import 'package:elbigayan/pages/organization/orghome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elbigayan/pages/sign_in.dart ';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
      ],
      child:
    const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbigayan',
      initialRoute: '/',
      debugShowCheckedModeBanner: false, 
      routes: {
        // '/': (context) => SignInPage(), 
        '/donation-drives': (context) => DonationDrivePage(),
        '/organization': (context) => const OrganizationHomePage(), 
      },
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage()
    );
  }
}