import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: Theme.of(context).backgroundColor,
      child: SpinKitSpinningLines(
        color: Theme.of(context).buttonColor,
        size: 100.0,
      ),
    );
  }
}
