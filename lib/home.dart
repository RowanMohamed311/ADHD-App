// ignore_for_file: prefer_const_constructors

import 'package:adhd_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  late String? email;
  Home(this.email);
  AuthBase _auth = AuthBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
              ),
              accountName: Text("UserName"),
              accountEmail:
                  email == null ? Text("UserName@example.com") : Text(email!),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  'U',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 49, 148, 153),
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 255, 250, 236),
              ),
            ),
            ListTile(
              title: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Icon(Icons.home),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Home"),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('home');
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.account_circle),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("ADHD info"))
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.accessibility),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("ADHD test"))
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.settings),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Settings"))
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
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
              title: Row(
                children: <Widget>[
                  Icon(Icons.logout),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Log out"))
                ],
              ),
              onTap: () async {
                await _auth.logout();
                // Navigator.of(context).pushReplacementNamed('login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'HOME',
          textAlign: TextAlign.center,
          style: GoogleFonts.acme(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
