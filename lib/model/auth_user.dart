import 'package:flutter/material.dart';

class AuthUser {
  final String uid;
  late String? firstname;
  late String? lastname;
  late String? gender;
  late int? age;
  final String? email;

  AuthUser(
    this.uid,
    this.email,
    this.age,
    this.gender,
    this.firstname,
    this.lastname,
  );
}
