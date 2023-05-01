import 'package:adhd_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import '../../widgets/google_facebook_buttons.dart';
import '../../widgets/original_button.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({required this.toggleview});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String _email = '';
  String _password = '';
  String _first_name = '';
  String _last_name = '';
  String _gender = '';
  int _age = 0;
  bool loading = false;
  // instamce from AuthBase
  AuthBase authBase = AuthBase();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.6,
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 60,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                            'WELCOME',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Color.fromARGB(255, 65, 79, 240),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 61,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                // height: 150,
                                // width: 175,
                                child: TextFormField(
                                  onChanged: (value) => _first_name = value,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter a Your name'
                                      : null,
                                  decoration: const InputDecoration(
                                    // contentPadding: EdgeInsets.all(10),
                                    labelText: 'First Name',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                // height: 150,
                                // width: 175,
                                child: TextFormField(
                                  onChanged: (value) => _last_name = value,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter a Your name'
                                      : null,
                                  decoration: const InputDecoration(
                                    // contentPadding: EdgeInsets.all(10),
                                    labelText: 'Last Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                // height: 150,
                                // width: 175,
                                child: TextFormField(
                                  onChanged: (value) => _gender = value,
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter a Your gender'
                                      : null,
                                  decoration: const InputDecoration(
                                    labelText: 'Gender',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                // height: 150,
                                // width: 175,
                                child: TextFormField(
                                  onChanged: (value) => _age = int.parse(value),
                                  validator: (value) => int.parse(value!) < 5 &&
                                          int.parse(value) > 88
                                      ? 'Please enter a correct Age!'
                                      : null,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
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
                          const SizedBox(
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
                          const SizedBox(
                            height: 5,
                          ),
                          OriginalButton(
                            text: 'Register',
                            //we used "widget" as we are using a variable from the stateful class and want to refer to it in the state itself."
                            // widget.authType == AuthType.login ? 'Login' : 'Register',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await authBase.registerWithEmailAndPassword(
                                        email: _email,
                                        password: _password,
                                        context: context,
                                        firstname: _first_name,
                                        lastname: _last_name,
                                        age: _age,
                                        gender: _gender);

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
                            child: const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17,
                              ),
                            ),
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
