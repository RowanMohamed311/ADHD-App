import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('wrapper');
        },
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              Text(
                'ADHD',
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(
                  color: Color.fromARGB(255, 65, 79, 240),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 40, left: 40),
                height: MediaQuery.of(context).size.height * 0.65,
                child: Lottie.network(
                  'https://assets1.lottiefiles.com/private_files/lf30_of3skn6w.json',
                  width: 400,
                  height: 400,
                  repeat: true,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Tap to Continue',
                style: TextStyle(
                  color: Color.fromARGB(255, 65, 79, 240),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
