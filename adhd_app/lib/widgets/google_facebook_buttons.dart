import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/widgets/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleFacbookWidget extends StatelessWidget {
  final AuthBase authBase;
  String firstname;
  String lastname;
  String gender;
  int age;
  bool flag;
  GoogleFacbookWidget(
      {required this.authBase,
      this.firstname = '',
      this.lastname = '',
      this.gender = '',
      this.age = 0,
      required this.flag});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '---------  OR  ---------',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () async {
                if (flag == true && age == 0) {
                  showSnackBar(context, 'Please enter Your Info first');
                } else {
                  dynamic goog = await authBase.signInWithGoogle(
                      context: context,
                      firstname: firstname,
                      lastname: lastname,
                      gender: gender,
                      age: age);
                }
              },
              icon: const Icon(FontAwesomeIcons.google),
              hoverColor: Colors.red,
              splashColor: Colors.red,
              color: Colors.red[900],
              iconSize: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () async {
                if (flag == true && age == 0) {
                  showSnackBar(context, 'Please enter Your Info first');
                } else {
                  dynamic face = await authBase.signInWithFacebook(
                      context: context,
                      firstname: firstname,
                      lastname: lastname,
                      gender: gender,
                      age: age);
                }
              },
              icon: const Icon(FontAwesomeIcons.facebookF),
              hoverColor: Colors.blue[900],
              splashColor: Colors.blue[900],
              color: Colors.blue[900],
              iconSize: 20,
            )
          ],
        ),
      ],
    );
  }
}
