import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? role;
  final List<String> roles = ['Donor', 'Organization', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Role",
                    border: OutlineInputBorder(),
                  ),
                  value: role,
                  onChanged: (String? newValue) {
                    setState(() {
                      role = newValue;
                    });
                  },
                  items: roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) => value == null ? 'Please select a role' : null,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (role != null) {
                        try {
                          await context.read<UserAuthProvider>().signUp(email!, password!, role!);
                          Navigator.of(context).pop();
                        } on FirebaseAuthException catch (e) {
                          final errorMessage = e.message ?? "An error occurred during sign up.";
                          _showErrorDialog(errorMessage);
                        } catch (e) {
                          _showErrorDialog("Failed to sign up. Please try again.");
                        }
                      } else {
                        _showErrorDialog("Please select a role to continue.");
                      }
                    }
                  },
                  child: const Text("Sign Up")
                )
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
        title: Text('Sign Up Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
