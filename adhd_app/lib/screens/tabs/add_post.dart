import 'package:adhd_app/model/auth_user.dart';
import 'package:adhd_app/screens/authenticate/wrapper.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/services/database.dart';
import 'package:adhd_app/widgets/form_widget.dart';
import 'package:adhd_app/widgets/tag_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String firstname = "firstname";
  String lastname = 'lastname';
  getUserData() async {
    final currentUserData = await FirebaseFirestore.instance
        .doc('/users/' + _auth.currentUser!.uid)
        .get();
    firstname = currentUserData['firstname'];
    lastname = currentUserData['lastname'];
    // setState(() {});
  }

  late String caption;
  late String tag;

  @override
  void initState() {
    super.initState();
    getUserData();
    caption = '';
    tag = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Wrapper()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        // color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 210,
                      ),
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: FloatingActionButton.extended(
                          heroTag: 'expand_post',
                          elevation: 2,
                          onPressed: AddPost,
                          backgroundColor: Theme.of(context).accentColor,
                          foregroundColor: Theme.of(context).backgroundColor,
                          label: const Text('Post'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Caption(),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 1,
                    key: Key(this.tag), // <- Magic!
                    initialValue: this.tag,
                    decoration: const InputDecoration(
                      hintText: 'Tag',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 250, 236),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                    ),
                    onChanged: (tag) => setState(() {
                      this.tag = tag;
                    }),
                    validator: (Tag) => Tag != null && Tag.isEmpty
                        ? 'The Tag cannot be empty'
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TagButton(
                          tag: 'Health',
                          writtentag: 'Health',
                          changeTag: (tag) => setState(() {
                            this.tag = tag;
                          }),
                        ),
                        TagButton(
                          tag: 'Advice',
                          writtentag: 'Advice',
                          changeTag: (tag) => setState(() {
                            this.tag = tag;
                          }),
                        ),
                        TagButton(
                          tag: 'ADHD',
                          writtentag: 'ADHD',
                          changeTag: (tag) => setState(() {
                            this.tag = tag;
                          }),
                        ),
                        TagButton(
                          tag: 'Question',
                          writtentag: 'Question',
                          changeTag: (tag) => setState(() {
                            this.tag = tag;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void AddPost() async {
    await DatabaseService(
      uid: _auth.currentUser!.uid,
    ).updatePostsData(caption, tag, _auth.currentUser!.email);
    await DatabaseService(uid: _auth.currentUser!.uid)
        .addUsersData(caption, tag, _auth.currentUser!.email);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
      (Route<dynamic> route) => false,
    );
  }

  Widget Caption() => TextFormField(
        maxLines: 20,
        initialValue: null,
        decoration: const InputDecoration(
          hintText: 'Caption',
          border: InputBorder.none,
          filled: true,
          fillColor: Color.fromARGB(255, 255, 250, 236),
          focusColor: Colors.white,
          hoverColor: Colors.white,
        ),
        onChanged: (caption) => setState(() {
          this.caption = caption;
        }),
        validator: (caption) => caption != null && caption.isEmpty
            ? 'The caption cannot be empty'
            : null,
      );
}
