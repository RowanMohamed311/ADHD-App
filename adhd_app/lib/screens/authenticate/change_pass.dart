import 'package:adhd_app/screens/authenticate/authenticate.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/widgets/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_form.dart';
import '../../onboarding/onboarding_text_button.dart';

class ChangePass extends StatefulWidget {
  // const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _formkey = GlobalKey<FormState>();

  var newPassword = " ";
  AuthBase authbase = AuthBase();
  late Future<bool> success;

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  // final currentUser = FirebaseAuth.instance.currentUser;

  // changePassword() async {
  //   try {
  //     await currentUser!.updatePassword(newPassword);
  //     FirebaseAuth.instance.signOut();
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => Authenticate(),
  //     //   ),
  //     // );
  //     showSnackBar(context, 'Your password have  been changed.. Login again! ');
  //   } catch (error) {
  //     showSnackBar(
  //         context, 'Your password have not been changed.. Try again! ');
  //     print('an error occurred');
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 255, 250, 236),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                // child: Image.asset("images/change.jpg"),
                child: Image.asset("assets/images/change.png"),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 17, left: 17, bottom: 40, top: 20),

                // margin: EdgeInsets.symmetric(vertical: 40.0),
                child: SizedBox(
                  width: 100.0,
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: ' New Password: ',
                      hintText: ' Enter New Password ',
                      labelStyle: const TextStyle(fontSize: 20.0),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                          color: Colors.black26, fontSize: 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Please Enter Password! ';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              MyTextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      newPassword = newPasswordController.text;
                    });
                    // changePassword();
                    dynamic success =
                        authbase.changePassword(newPassword: newPassword);
                    if (success != null) {
                      authbase.logout();
                      Navigator.of(context).pushReplacementNamed('wrapper');
                      showSnackBar(context,
                          'Your password have  been changed.. Login again! ');
                    } else {
                      showSnackBar(context,
                          'Your password have not been changed.. try again! ');
                    }
                  }
                },
                buttonName: ' Change Password ',
                textcolor: Colors.white,
                bgColor: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
