import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthUser {
  final String uid;
  final String? firstname;
  final String? lastname;
  final String? gender;
  final int? age;
  final String? email;

  AuthUser(
    this.uid,
    this.email,
    this.age,
    this.gender,
    this.firstname,
    this.lastname,
  );

  static AuthUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AuthUser(snapshot['uid'], snapshot['email'], snapshot['age'],
        snapshot['gender'], snapshot['firstname'], snapshot['lastname']);
  }
}
