import 'package:flutter/material.dart';
import 'package:adhd_app/screens/authenticate/login_form.dart';
import 'package:adhd_app/screens/authenticate/register_form.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleSignIn() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return LogInForm(
        toggleview: toggleSignIn,
      );
    } else {
      return Register(
        toggleview: toggleSignIn,
      );
    }
  }
}
