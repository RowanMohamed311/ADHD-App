import 'package:adhd_app/screens/tabs/feed/home.dart';
import 'package:adhd_app/model/auth_user.dart';

import 'package:adhd_app/screens/authenticate/authenticate.dart';
import 'package:adhd_app/screens/tabs/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavigation();
    }
  }
}
