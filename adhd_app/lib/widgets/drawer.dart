import 'package:adhd_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
            ),
            accountName: _auth.currentUser!.displayName == null
                ? const Text('username')
                : Text(_auth.currentUser!.displayName!),
            accountEmail: _auth.currentUser!.email == null
                ? const Text('UserName@example.com')
                : Text(
                    _auth.currentUser!.email!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
          ),
          ListTile(
            title: Row(
              children: const <Widget>[
                Icon(Icons.person),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "User Profile",
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('Userprofile');
            },
          ),
          ListTile(
            title: Row(
              children: const <Widget>[
                Icon(Icons.medical_information),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("ADHD info"),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('adhdinfo');
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('adhdtest');
            },
            title: Row(
              children: const <Widget>[
                Icon(Icons.medication_liquid),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("ADHD Test"))
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: const <Widget>[
                Icon(FontAwesomeIcons.peopleLine),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Community"))
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('onboarding');
              // Navigator.of(context).pushReplacementNamed('login');
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('saved_items');
            },
            title: Row(
              children: const <Widget>[
                Icon(Icons.bookmark),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Saved Items"))
              ],
            ),
          ),
          ListTile(
            title: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Icon(Icons.lock_reset),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Change Password"),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('change_password');
            },
          ),
          ListTile(
            title: Row(
              children: const <Widget>[
                Icon(Icons.logout),
                Padding(
                    padding: EdgeInsets.only(left: 8.0), child: Text("Log out"))
              ],
            ),
            onTap: () async {
              await _auth.signOut();
              // Navigator.of(context).pushReplacementNamed('login');
            },
          ),
        ],
      ),
    );
  }
}
