import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({Key? key}) : super(key: key);

  @override
  State<SignUpDonorPage> createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? username;
  String? address;
  String? contactNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up as Donor")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFcdffd8), Color(0xFF94b9ff)],
          ),
        ),
        child: SingleChildScrollView(
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
                      "Sign Up as Donor",
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          await context.read<UserAuthProvider>().signUp(
                            email!, 
                            password!, 
                            'Donor', // Default role is Donor
                            additionalData: {
                              'name': name,
                              'username': username,
                              'address': address,
                              'contactNo': contactNo,
                              'isApproved': false,
                            },
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
