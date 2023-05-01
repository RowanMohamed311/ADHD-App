import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  // const OriginalButton({Key? key}) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color textcolor;
  final Color backColor;

  const OriginalButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textcolor,
      required this.backColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: textcolor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
