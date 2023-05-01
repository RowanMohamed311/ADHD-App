import 'package:adhd_app/services/database.dart';
import 'package:adhd_app/widgets/gender_avatar.dart';
import 'package:adhd_app/widgets/time_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  dynamic uid;
  dynamic username;
  dynamic useremail;
  dynamic time;
  UserDetails(
      {Key? key,
      required this.uid,
      required this.username,
      this.useremail,
      required this.time})
      : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  //! the variable related to the state .
  String gender = "";
  @override
  void initState() {
    getUserGender();
    super.initState();
  }

  getUserGender() {
    DatabaseService(uid: widget.uid)
        .getUserGender(userid: widget.uid)
        .then((value) {
      setState(() {
        gender = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            maxRadius: 15,
            backgroundImage: gender == "Male"
                ? const AssetImage('assets/images/aboy.png')
                : gender == "Female"
                    ? const AssetImage('assets/images/agirl.png')
                    : const AssetImage('assets/images/user.png'),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.username,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.useremail ?? '',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: TimeFormat(sortTime: widget.time),
        ),
      ],
    );
  }
}
