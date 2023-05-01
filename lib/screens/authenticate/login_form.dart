// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/shared/loading.dart';
import 'package:adhd_app/widgets/google_facebook_buttons.dart';
import 'package:adhd_app/widgets/original_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInForm extends StatefulWidget {
  final Function toggleview;
  LogInForm({required this.toggleview});
  // final AuthType authType;

  // const LogInForm({Key? key, required this.authType}) : super(key: key);
  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String _email = '';
  String _password = '';
  bool loading = false;
  // instamce from AuthBase
  AuthBase authBase = AuthBase();
  @override
  Widget build(BuildContext context) {
    // Form widget to simplify the validation  methods.
    return loading
        ? Loading()
        : Scaffold(
            // width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height * 0.6,
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 60),
                height: MediaQuery.of(context).size.height * 0.9,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 80,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 30,
                          // ),
                          Text(
                            'WELCOME',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Color.fromARGB(255, 65, 79, 240),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (value) => _email = value,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a Valid Email' : null,
                            decoration: const InputDecoration(
                              labelText: 'Enter Your Email',
                              hintText: 'test@example.com',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onChanged: (value) => _password = value,
                            validator: (value) => value!.length < 6
                                ? 'Password must be more than 6 char.'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Enter Your Password',
                              suffixIcon: IconButton(
                                color: Theme.of(context).cursorColor,
                                onPressed: () {
                                  setState(() {
                                    _pass = !_pass;
                                  });
                                },
                                icon: Icon(_pass
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            obscureText: _pass,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          OriginalButton(
                            text: 'Login',
                            //we used "widget" as we are using a variable from the stateful class and want to refer to it in the state itself."
                            // widget.authType == AuthType.login ? 'Login' : 'Register',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await authBase.loginWithEmailAndPassword(
                                        email: _email,
                                        password: _password,
                                        context: context);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            textcolor: Colors.white,
                            backColor: Theme.of(context).buttonColor,
                          ),
                          FlatButton(
                            onPressed: () {
                              widget.toggleview();
                            },
                            child: Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GoogleFacbookWidget(authBase: authBase),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
