import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle defaultTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    return Drawer(
      child: Container(
        color: const Color(0xFFE8FFFF),
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ListView(padding: EdgeInsets.zero, children: [
            const SizedBox(
              height: 60,
            ),
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
              title: const Text(
                'Admin',
                style: defaultTextStyle,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Logout',
                style: defaultTextStyle, 
              ),
              onTap: () async {
                await Provider.of<UserAuthProvider>(context, listen: false).signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}
