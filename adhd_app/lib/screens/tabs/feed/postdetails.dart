import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  String caption;
  String tag;
  PostDetails({Key? key, required this.caption, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          tag,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
