import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_client/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late FirebaseAuth auth;
  late bool isEmailVerified;

  bool isSwitched = false;
  bool isDarkMode = true;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    isEmailVerified = auth.currentUser!.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
              ),
              title: Text(auth.currentUser!.displayName!),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: isEmailVerified ? Colors.green : null,
              ),
              title: Text(auth.currentUser!.email!),
            ),
            ListTile(
              leading: Icon(
                Icons.verified,
                color: isEmailVerified ? Colors.green : null,
              ),
              title: const Text('Email Verified'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              title: const Text('Receive notifications'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Theme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              title: const Text('Dark Mode'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Privacy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Privacy Policy'),
              onTap: () {
                // navigate to privacy policy page
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await auth.signOut().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
