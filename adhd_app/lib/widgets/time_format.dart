import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormat extends StatelessWidget {
  dynamic sortTime;
  TimeFormat({Key? key, required this.sortTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('d-M-yy h:mma');
    String tt = sortTime == null ? "" : format.format(sortTime.toDate());
    return Text(
      tt,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
