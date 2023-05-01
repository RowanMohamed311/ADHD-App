// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String mesg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        mesg,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).buttonColor,
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    ),
  );
  // key.currentState?.showSnackBar(snackbar);
}
