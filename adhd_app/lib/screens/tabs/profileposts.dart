import 'package:adhd_app/screens/tabs/feed/postdetails.dart';
import 'package:adhd_app/screens/tabs/feed/postinteractions.dart';
import 'package:adhd_app/screens/tabs/feed/userdetails.dart';
import 'package:adhd_app/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:adhd_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfilePosts extends StatelessWidget {
  // AuthBase _auth = AuthBase();
  final String id = FirebaseAuth.instance.currentUser!.uid;
  // var uid = (FirebaseAuth.instance.currentUser!).uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(context: context, auth: _auth),
      appBar: AppBar(
        title: Text(
          'MY POSTS',
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
        // child: FutureBuilder(
        //   future: FirebaseAuth.instance.currentUser(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //  if (!snapshot.hasData) {
        //   return circularProgress();
        // }
        // return StreamBuilder<QuerySnapshot>(

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .where('uid', isEqualTo: id)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (!snapshot.hasData) {
            //   return circularProgress();
            // }
            if (!snapshot.hasData) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final sortTime = snapshot.data!.docs[index].get("timestamp");
                  String serverTime =
                      sortTime == null ? "" : sortTime.toDate().toString();

                  return Card(
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
                            caption: snapshot.data!.docs[index].get('caption'),
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
