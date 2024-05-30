import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpOrganizationPage extends StatefulWidget {
  const SignUpOrganizationPage({super.key});

  @override
  State<SignUpOrganizationPage> createState() => _SignUpOrganizationPageState();
}

class _SignUpOrganizationPageState extends State<SignUpOrganizationPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? username;
  String? address;
  String? contactNo;
  String? orgName;
  String? aboutOrg;
  File? proofOfLegitimacy;

  Future<void> _pickProofOfLegitimacy() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        proofOfLegitimacy = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up as Organization")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Sign Up as Organization",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                      hintText: "Enter your name"),
                    onSaved: (value) => name = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Username"),
                      hintText: "Enter your username"),
                    onSaved: (value) => username = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      hintText: "Enter a valid email"),
                    onSaved: (value) => email = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid email format";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      hintText: "At least 8 characters"),
                    obscureText: true,
                    onSaved: (value) => password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid password";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Address"),
                      hintText: "Enter your address"),
                    onSaved: (value) => address = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Contact No."),
                      hintText: "Enter your contact number"),
                    onSaved: (value) => contactNo = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your contact number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Organization Name"),
                      hintText: "Enter organization name"),
                    onSaved: (value) => orgName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the organization name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("About your organization"),
                      hintText: "Enter details about your organization"),
                    onSaved: (value) => aboutOrg = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter details about your organization";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickProofOfLegitimacy,
                  child: Text(proofOfLegitimacy == null ? "Upload Proof of Legitimacy" : "Proof Selected"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        Map<String, dynamic> additionalData = {
                          'name': name,
                          'username': username,
                          'address': address,
                          'contactNo': contactNo,
                          'orgName': orgName,
                          'aboutOrg': aboutOrg,
                          'proofOfLegitimacy': proofOfLegitimacy?.path,
                        };
                        await context.read<UserAuthProvider>().signUp(
                          email!, 
                          password!, 
                          'Organization',
                          additionalData: additionalData,
                        );
                        Navigator.of(context).pushNamed('/login');
                      } on FirebaseAuthException catch (e) {
                        final errorMessage = e.message ?? "An error occurred during sign up.";
                        _showErrorDialog(errorMessage);
                      } catch (e) {
                        _showErrorDialog("Failed to sign up. Please try again.");
                      }
                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Up Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
