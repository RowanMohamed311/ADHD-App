import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './size_configs.dart';

Color kPrimaryColor = Color.fromARGB(255, 255, 146, 147);
//Color kPrimaryColor =Color.fromARGB(255, 97, 107, 255);
Color kSecondaryColor = Color.fromARGB(255, 65, 79, 240);
// Color kSecondaryColor = Color(0xff573353);

final kTitle = GoogleFonts.acme(
  color: Color.fromARGB(255, 65, 79, 240),
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  fontWeight: FontWeight.bold,
);
