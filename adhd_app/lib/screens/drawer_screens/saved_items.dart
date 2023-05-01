import 'package:adhd_app/screens/tabs/feed/postinteractions.dart';
import 'package:adhd_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../authenticate/wrapper.dart';
import '../tabs/feed/postdetails.dart';
import '../tabs/feed/userdetails.dart';

class SavedItems extends StatefulWidget {
  SavedItems({Key? key}) : super(key: key);

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  final String id = FirebaseAuth.instance.currentUser!.uid;
  List postIds = [];
  Stream<QuerySnapshot>? posts;

  // var uid = (FirebaseAuth.instance.currentUser!).uid;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getSavedPost(id);
    // print(DatabaseService(uid: id).getPostSaved(id).toString());
  }

  getSavedPost(String userid) async {
    DatabaseService(uid: id).getSavedPosts(userid: id).then((value) {
      setState(() {
        postIds = value;
        print(postIds);
        posts = FirebaseFirestore.instance
            .collection("posts")
            .where('postid', whereIn: postIds)
            .snapshots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(context: context, auth: _auth),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Wrapper()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          'Saved Items',
          textAlign: TextAlign.left,
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
          stream: posts,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            if (!snapshot.hasData) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final sortTime = snapshot.data!.docs[index].get("timestamp");
                  var format = DateFormat('d-M-yy\nh:mm a');
                  String tt =
                      sortTime == null ? "" : format.format(sortTime.toDate());

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
                            likes: snapshot.data!.docs[index].get('likes'),
                            comments:
                                snapshot.data!.docs[index].get('comments'),
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

  getPostData(String pid) async {
    final currentdata =
        await FirebaseFirestore.instance.doc('/posts/' + pid).get();
    return currentdata;
  }
}
