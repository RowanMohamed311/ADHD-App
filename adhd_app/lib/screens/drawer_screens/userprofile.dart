import 'package:adhd_app/shared/size_configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adhd_app/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:adhd_app/services/auth.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => userprofile();
}

class userprofile extends State<UserProfile> {
  String firstname = "firstname";
  String lastname = 'lastname';
  int age = 0;
  String gender = "gender";
  final id = FirebaseAuth.instance.currentUser!.uid;
  getUserData() async {
    final currentUserData =
        await FirebaseFirestore.instance.doc('/users/' + id).get();

    age = currentUserData['age'];
    firstname = currentUserData['firstname'];
    gender = currentUserData['gender'];
    lastname = currentUserData['lastname'];
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  var flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('User page'),
        backgroundColor: Theme.of(context).buttonColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('wrapper');
          },
        ),
      ),
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.6,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.99,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 60,
                ),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        child: Column(children: [
                          const SizedBox(height: 0.1),
                          Center(
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 101, 137, 225),
                              radius: 80,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                radius: 65,
                                backgroundImage: gender == "Male"
                                    ? AssetImage('assets/images/aboy.png')
                                    : gender == "Female"
                                        ? AssetImage('assets/images/agirl.png')
                                        : AssetImage('assets/images/user.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // const SizedBox(
                              //   height: 90,
                              // ),
                              // const Padding(
                              //   padding: EdgeInsets.all(3),
                              // ),
                              Expanded(
                                child: TextFormField(
                                  key: Key(firstname),
                                  enabled: flag,
                                  initialValue: firstname,
                                  onChanged: (value) => firstname = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Firstname',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(221, 17, 27, 170),
                                        fontSize: 25,
                                        fontFamily: 'AvenirLight'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                                height: 40,
                              ),
                              Expanded(
                                // height: 150,
                                // width: 175,
                                child: TextFormField(
                                  key: Key(lastname),
                                  enabled: flag,
                                  initialValue: lastname,
                                  onChanged: (value) => lastname = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Lastname',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(221, 17, 27, 170),
                                        fontSize: 25,
                                        fontFamily: 'AvenirLight'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
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
                                  key: Key(gender),
                                  readOnly: true,
                                  initialValue: gender,
                                  onChanged: (value) => gender = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Gender',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(221, 17, 27, 170),
                                        fontSize: 25,
                                        fontFamily: 'AvenirLight'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: Key(age.toString()),
                                  enabled: flag,
                                  initialValue: age.toString(),
                                  onChanged: (value) => value == null
                                      ? age = int.parse(value)
                                      : null,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(221, 17, 27, 170),
                                        fontSize: 25,
                                        fontFamily: 'AvenirLight'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              flag = true;
                            }),
                            child: const Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 65, 79, 240),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              DatabaseService(uid: id).updateUserData(
                                  firstname, lastname, age, gender);

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content:
                                      const Text('User Updated Successfully'),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('ok'),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ),
                              );
                            }),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 65, 79, 240),
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )
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
