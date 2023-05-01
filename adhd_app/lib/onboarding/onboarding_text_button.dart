import 'package:flutter/material.dart';
import '../shared/size_configs.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
    required this.textcolor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: TextStyle(
                fontSize: 20, color: textcolor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
