import 'package:flutter/material.dart';

class TagButton extends StatelessWidget {
  String tag;
  String writtentag;

  ValueChanged<String> changeTag;
  TagButton(
      {required this.tag,
      required this.writtentag,
      required this.changeTag,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 80,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () {
          changeTag(writtentag);
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(248, 130, 176, 244),
                Color.fromARGB(248, 130, 176, 244)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
