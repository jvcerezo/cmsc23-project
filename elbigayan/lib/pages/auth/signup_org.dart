import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpOrganizationPage extends StatefulWidget {
  const SignUpOrganizationPage({Key? key}) : super(key: key);

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFcdffd8), Color(0xFF94b9ff)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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
                  buildTextFormField(
                    labelText: "Name",
                    hintText: "Enter your name",
                    onSave: (value) => name = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "Username",
                    hintText: "Enter your username",
                    onSave: (value) => username = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  // Repeat this pattern for other TextFormField widgets
                  buildTextFormField(
                    labelText: "Email",
                    hintText: "Enter a valid email",
                    onSave: (value) => email = value,
                    validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email format";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "Password",
                    hintText: "At least 8 characters",
                    obscureText: true,
                    onSave: (value) => password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return "Password must be at least 8 characters long";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "Address",
                    hintText: "Enter your address",
                    onSave: (value) => address = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "Contact No.",
                    hintText: "Enter your contact number",
                    onSave: (value) => contactNo = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your contact number";
                      } else if (!RegExp(r'^09\d{9}$').hasMatch(value)) {
                        return "Contact number must start with 09 and be 11 digits long";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "Organization Name",
                    hintText: "Enter organization name",
                    onSave: (value) => orgName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the organization name";
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    labelText: "About your organization",
                    hintText: "Enter details about your organization",
                    onSave: (value) => aboutOrg = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter details about your organization";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _pickProofOfLegitimacy,
                    child: Text(proofOfLegitimacy == null ? "Upload Proof of Legitimacy" : "Proof Selected"),
                  ),
                      SizedBox(height: 20),
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
      ),
    );
  }

  Widget buildTextFormField({
    required String labelText,
    required String hintText,
    required Function(String?) onSave,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[900]!, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue[100],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            hintText: hintText,
          ),
          obscureText: obscureText,
          onSaved: onSave as void Function(String?)?,
          validator: validator,
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
