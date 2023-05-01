import 'package:adhd_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleFacbookWidget extends StatelessWidget {
  final AuthBase authBase;
  const GoogleFacbookWidget({required this.authBase});

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
                dynamic goog = await authBase.signInWithGoogle(context);
              },
              icon: const Icon(FontAwesomeIcons.google),
              hoverColor: Colors.red,
              splashColor: Colors.red,
              color: Colors.red[900],
              iconSize: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () async {
                dynamic face = await authBase.signInWithFacebook(context);
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
