import 'package:elbigayan/pages/admin/admin_homepage.dart';
import 'package:elbigayan/pages/organization/orgdonation_drive_page.dart';
import 'package:elbigayan/pages/organization/orghome_page.dart';
import 'package:elbigayan/pages/Donor/donorhome_page.dart';
import 'package:elbigayan/pages/Donor/donorprofile_page.dart';
import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:elbigayan/pages/organization/orgprofile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elbigayan/pages/sign_in.dart';
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbigayan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Consumer<UserAuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.user != null) {
            switch (authProvider.userRole) {
              case 'Admin':
                return const AdminDashboard();
              case 'Organization':
                return const OrganizationHomePage();
              case 'Donor':
                return const DonorHomePage();
              default:
                return const SignInPage();
            }
          } else {
            return const SignInPage();
          }
        },
      ),
      routes: {
        '/donation-drives': (context) => const DonationDrivePage(),
        '/organization': (context) => const OrganizationHomePage(),
        '/organization-profile': (context) => const OrgProfilePage(),
        '/donor-home': (context) => const DonorHomePage(),
        '/donor-profile': (context) => const DonorProfilePage(),
        '/donor-donation': (context) => const DonationPage(),
        '/admin': (context) => const AdminDashboard(),
        '/login': (context) => const SignInPage(),
      },
    );
  }
}
