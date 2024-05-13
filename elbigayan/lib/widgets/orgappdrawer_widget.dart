import 'package:flutter/material.dart';

class OrganizationAppDrawer extends StatelessWidget {
  const OrganizationAppDrawer({Key? key}) : super(key: key);

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
                'Organization',
                style: defaultTextStyle,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: const Text(
                'Home',
                style: defaultTextStyle, 
              ),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name ==
                    '/') {
                  Navigator.of(context)
                      .pop(); 
                } else {
                  Navigator.pushNamed(context, '/');
                }
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Donation Drives',
                style: defaultTextStyle,
              ),
              onTap: () {
                if (ModalRoute.of(context)!.settings.name ==
                    '/donation-drives') {
                  Navigator.of(context)
                      .pop(); 
                } else {
                  Navigator.pushNamed(context, '/donation-drives');
                }
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Profile',
                style: defaultTextStyle, 
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Logout',
                style: defaultTextStyle, 
              ),
              onTap: () {},
            ),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}