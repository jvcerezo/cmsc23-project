import 'package:elbigayan/pages/admin/admin_homepage.dart';
import 'package:elbigayan/pages/organization/orgdonation_drive_page.dart';
import 'package:elbigayan/pages/organization/orghome_page.dart';
import 'package:elbigayan/pages/Donor/donorhome_page.dart';
import 'package:elbigayan/pages/Donor/donorprofile_page.dart';
import 'package:elbigayan/pages/Donor/donation_page.dart';
import 'package:elbigayan/pages/organization/orgprofile_page.dart';
import 'package:elbigayan/pages/organization/scan_code_page.dart';
import 'package:elbigayan/providers/donationdrive_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/pages/auth/sign_in.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'providers/organization_provider.dart';
import 'providers/donation_provider.dart';
import 'package:elbigayan/pages/admin/donor_list_page.dart';
import 'package:elbigayan/pages/admin/organization_list_page.dart';
import 'package:elbigayan/pages/admin/approval_organization_page.dart';
import 'package:elbigayan/pages/auth/signup_donor.dart';
import 'package:elbigayan/pages/auth/signup_org.dart';
import 'package:elbigayan/pages/admin/donation_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => DonationDriveListProvider())),
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => OrganizationProvider()),
        ChangeNotifierProvider(create: (context) => DonationProvider()),
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
        'scan-code': (context) => const ScanCodePage(),
        '/organizations-list': (context) => const OrganizationListPage(),
        '/donors-list': (context) => const DonorListPage(),
        '/approve-organization': (context) => const ApprovalPage(),
        '/signup-donor' : (context) => const SignUpDonorPage(),
        '/signup-organization' : (context) => const SignUpOrganizationPage(),
        '/donations-list': (context) => const DonationsListPage(),
      },
    );
  }
}
