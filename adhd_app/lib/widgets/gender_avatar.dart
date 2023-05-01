import 'package:adhd_app/services/database.dart';
import 'package:flutter/material.dart';

class GenderAvatar extends StatefulWidget {
  String uid;
  GenderAvatar({Key? key, required this.uid}) : super(key: key);

  @override
  State<GenderAvatar> createState() => _GenderAvatarState();
}

class _GenderAvatarState extends State<GenderAvatar> {
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
    return CircleAvatar(
      maxRadius: 15,
      backgroundImage: gender == "Male"
          ? const AssetImage('assets/images/aboy.png')
          : gender == "Female"
              ? const AssetImage('assets/images/agirl.png')
              : const AssetImage('assets/images/user.png'),
    );
  }
}
