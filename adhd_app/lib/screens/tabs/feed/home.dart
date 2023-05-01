// ignore_for_file: prefer_const_constructors

import 'package:adhd_app/screens/tabs/feed/comments_page.dart';
import 'package:adhd_app/screens/tabs/feed/postdetails.dart';
import 'package:adhd_app/screens/tabs/feed/postinteractions.dart';
import 'package:adhd_app/screens/tabs/feed/userdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: appDrawer(context: context, auth: _auth),
      appBar: AppBar(
        title: Text(
          'HOME',
          textAlign: TextAlign.center,
          style: GoogleFonts.acme(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            if (!snapshot.hasData) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPage(
                            
                            postid: snapshot.data!.docs[index].get('postid'),
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            UserDetails(
                              uid: snapshot.data!.docs[index].get('uid'),
                              username:
                                  snapshot.data!.docs[index].get('username'),
                              useremail:
                                  snapshot.data!.docs[index].get('useremail'),
                              time: snapshot.data!.docs[index].get("timestamp"),
                            ),
                            Divider(
                              color: Theme.of(context).buttonColor,
                            ),
                            PostDetails(
                              caption:
                                  snapshot.data!.docs[index].get('caption'),
                              tag: snapshot.data!.docs[index].get('tag'),
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
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          },
        ),
      ),
    );
  }
}
