//import 'dart:html';

import 'package:adhd_app/screens/tabs/feed/postdetails.dart';
import 'package:adhd_app/screens/tabs/feed/postinteractions.dart';
import 'package:adhd_app/screens/tabs/feed/userdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class searchPosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => searchPostsPage();
}

final CollectionReference postsCollection =
    FirebaseFirestore.instance.collection('posts');

class searchPostsPage extends State<searchPosts> {
  TextEditingController searchController = TextEditingController();
  Stream<QuerySnapshot<Object?>>? SearchResultsFuture;

  handlesearch(String query) {
    Stream<QuerySnapshot<Object?>> tags =
        postsCollection.where("tag", isEqualTo: query).snapshots();
    setState(() {
      SearchResultsFuture = tags;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar BuildSearchField() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 255, 250, 236),
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9.0),
          border: const OutlineInputBorder(
              //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                color: Colors.redAccent,
                width: 3,
              )),
          hintText: "Search Using tags ....",
          // filled: true,
          prefixIcon: const Icon(
            Icons.search,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            onPressed: (() => clearSearch()),
            icon: const Icon(Icons.clear),
          ),
        ),
        onFieldSubmitted: (value) => handlesearch(value),
      ),
    );
  }

  BuildSearchResults() {
    return StreamBuilder<QuerySnapshot>(
        stream: SearchResultsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  final sortTime = snapshot.data!.docs[index].get("timestamp");
                  String serverTime =
                      sortTime == null ? "" : sortTime.toDate().toString();
                  return Card(
                    elevation: 4,
                    child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: <Widget>[
                          UserDetails(
                            uid: "${snapshot.data?.docs[index]['uid']}",
                            username:
                                "${snapshot.data?.docs[index]['username']}",
                            useremail:
                                "${snapshot.data?.docs[index]['useremail']}",
                            time: serverTime,
                          ),
                          Divider(
                            color: Theme.of(context).buttonColor,
                          ),
                          PostDetails(
                            caption: "${snapshot.data?.docs[index]['caption']}",
                            tag: "${snapshot.data?.docs[index]['tag']}",
                          ),
                          Divider(
                            color: Colors.grey[5],
                          ),
                          PostInteractions(
                            userid: FirebaseAuth.instance.currentUser!.uid,
                            comments:
                                snapshot.data!.docs[index].get('comments'),
                            likes: snapshot.data!.docs[index].get('likes'),
                            postid: snapshot.data!.docs[index].get('postid'),
                            saved: snapshot.data!.docs[index].get('saved'),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return LinearProgressIndicator(
            color: Theme.of(context).primaryColorDark,
          );
        });
  }

  Buildnocontent() {
    return Center(
      child: Text(
        "No Contents",
        textAlign: TextAlign.center,
        style: GoogleFonts.acme(
          color: Color.fromARGB(255, 65, 79, 240),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: BuildSearchField()),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SearchResultsFuture == null
            ? Buildnocontent()
            : BuildSearchResults(),
      ),
    );
  }
}
