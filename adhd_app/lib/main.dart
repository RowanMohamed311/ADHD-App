// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:adhd_app/screens/authenticate/change_pass.dart';
import 'package:adhd_app/screens/drawer_screens/adhdtest.dart';
import 'package:adhd_app/screens/drawer_screens/saved_items.dart';
// import 'package:adhd_app/screens/authenticate/change_pass.dart';
import 'package:adhd_app/screens/tabs/feed/home.dart';
import 'package:adhd_app/screens/authenticate/authenticate.dart';
import 'package:adhd_app/screens/authenticate/login_form.dart';
import 'package:adhd_app/screens/drawer_screens/adhdInfo.dart';
import 'package:adhd_app/screens/drawer_screens/userprofile.dart';
import 'package:adhd_app/screens/welcome.dart';
import 'package:adhd_app/screens/authenticate/wrapper.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/onboarding/onboarding_page.dart';
import 'package:adhd_app/shared/size_configs.dart';
import 'package:adhd_app/screens/community_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/tabs/feed/home.dart';
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
          primaryTextTheme: TextTheme(
            titleLarge: GoogleFonts.acme(
              color: Color.fromARGB(255, 65, 79, 240),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodyLarge: TextStyle(
              color: Color.fromARGB(255, 65, 79, 240),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          primaryColor: Color.fromARGB(248, 211, 228, 253),
          backgroundColor: Color.fromARGB(255, 255, 250, 236),
          buttonColor: Color.fromARGB(255, 65, 79, 240),
          accentColor: Color.fromARGB(248, 130, 176, 244),
          primaryColorDark: Color.fromARGB(255, 65, 79, 240),
          // buttonTheme: ButtonTheme(buttonColor: Color.fromARGB(255,, 146, 147),child: ,),
          // colorScheme: ColorScheme(brightness: Brightness.light, primary: , onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)
          errorColor: Color.fromARGB(255, 101, 137, 225),
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
          'authenticate': (context) => Authenticate(),
          'change_password': (context) => ChangePass(),
          'communitypage': (context) => CommunityPage(),
          'adhdinfo': (context) => ADHD(),
          'Userprofile': (context) => UserProfile(),
          'adhdtest': (context) => AdhdTest(),
          'saved_items': (context) => SavedItems(),
        },
      ),
    );
  }
}
