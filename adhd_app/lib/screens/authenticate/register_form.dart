import 'package:adhd_app/widgets/loading.dart';
import 'package:adhd_app/widgets/showSnackBar.dart';
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
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String _email = '';
  String _password = '';
  String _first_name = '';
  String _last_name = '';
  String _gender = '';
  int _age = 0;
  bool loading = false;
  // Initial Selected Value
  String dropdownvalue = 'Gender';

  // List of items in our dropdown menu
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"), value: "Male"),
      const DropdownMenuItem(child: Text("Female"), value: "Female"),
    ];
    return menuItems;
  }

  // instamce from AuthBase
  AuthBase authBase = AuthBase();
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.6,
              backgroundColor: Theme.of(context).backgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 30,
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
                                color: const Color.fromARGB(255, 65, 79, 240),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 61,
                              ),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            // filled: true,
                                            // fillColor: Colors.blueAccent,
                                          ),
                                          validator: (value) => value == null
                                              ? "Select a Gender"
                                              : null,
                                          dropdownColor:
                                              Theme.of(context).backgroundColor,
                                          // value: dropdownvalue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                              _gender = newValue;
                                            });
                                          },
                                          items: dropdownItems),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  // height: 150,
                                  // width: 175,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) =>
                                        _age = int.parse(value),
                                    validator: (value) => value == null &&
                                            int.parse(value!) < 5 &&
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
                                  await authBase
                                      .registerWithEmailAndPassword(
                                          email: _email,
                                          password: _password,
                                          context: context,
                                          firstname: _first_name,
                                          lastname: _last_name,
                                          age: _age,
                                          gender: _gender)
                                      .then((value) {
                                    if (value == true) {
                                      print('rowaaaaaaaaan');
                                    } else {
                                      setState(() => loading = false);
                                    }
                                  });
                                }
                              },
                              textcolor: Colors.white,
                              backColor: Theme.of(context).errorColor,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.toggleview();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Theme.of(context).backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            GoogleFacbookWidget(
                                authBase: authBase,
                                flag: true,
                                age: _age,
                                firstname: _first_name,
                                gender: _gender,
                                lastname: _last_name),
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
