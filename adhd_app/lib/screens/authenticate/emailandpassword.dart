import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/widgets/loading.dart';
import 'package:adhd_app/widgets/original_button.dart';
import 'package:flutter/material.dart';

class EmailandPassword extends StatefulWidget {
  String first_name;
  String last_name;
  String gender;
  int age;
  final AuthBase authBase;
  EmailandPassword(
      {Key? key,
      required this.first_name,
      required this.last_name,
      required this.gender,
      required this.age,
      required this.authBase})
      : super(key: key);

  @override
  State<EmailandPassword> createState() => _EmailandPasswordState();
}

class _EmailandPasswordState extends State<EmailandPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String _email = '';
  String _password = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.6,
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 120,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextFormField(
                              onChanged: (value) => _email = value,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a Valid Email' : null,
                              decoration: const InputDecoration(
                                labelText: 'Enter Your Email',
                                hintText: 'test@example.com',
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) => _password = value,
                              validator: (value) => value!.length < 6
                                  ? 'Password must be more than 6 char.'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Enter Your Password',
                                suffixIcon: IconButton(
                                  color: Theme.of(context).errorColor,
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
                            OriginalButton(
                              text: 'Register',
                              //we used "widget" as we are using a variable from the stateful class and want to refer to it in the state itself."
                              // widget.authType == AuthType.login ? 'Login' : 'Register',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await widget.authBase
                                      .registerWithEmailAndPassword(
                                          email: _email,
                                          password: _password,
                                          context: context,
                                          firstname: widget.first_name,
                                          lastname: widget.last_name,
                                          age: widget.age,
                                          gender: widget.gender);

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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
