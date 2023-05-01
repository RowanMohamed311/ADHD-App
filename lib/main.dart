// ignore_for_file: prefer_const_constructors

import 'package:adhd_app/home.dart';
import 'package:adhd_app/screens/authenticate/login_form.dart';
import 'package:adhd_app/screens/welcome.dart';
import 'package:adhd_app/screens/wrapper.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/views/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './views/pages.dart';

import 'home.dart';
import 'model/auth_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      initialData: null,
      value: AuthBase().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ADHD APP',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 49, 148, 153),
          backgroundColor: Color.fromARGB(255, 255, 250, 236),
          buttonColor: Color.fromARGB(255, 65, 79, 240),
          accentColor: Color.fromARGB(255, 250, 190, 124),
          primaryColorDark: Color.fromARGB(255, 255, 146, 147),
          // buttonTheme: ButtonTheme(buttonColor: Color.fromARGB(255,, 146, 147),child: ,),
          // colorScheme: ColorScheme(brightness: Brightness.light, primary: , onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)
          cursorColor: Color.fromARGB(255, 101, 137, 225),
          // iconTheme: IconTheme(data: , child: child),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(240, 255, 250, 236),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        home: Welcome(),
        // This "routes" property to pre-define the navigators to get called by name only afterwards.
        routes: {
          // 'home': (context) => Home(),
          'wrapper': (context) => Wrapper(),
          'onboarding': (context) => OnBoardingPage(),
        },
      ),
    );
  }
}
