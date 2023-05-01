import 'package:adhd_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'comments_page.dart';

class PostInteractions extends StatefulWidget {
  final Map likes;
  final String userid;
  final String postid;
   final int comments;
  final Map saved;

  PostInteractions(
      {required this.likes,
      required this.userid,
      required this.postid,
      required this.comments,
      required this.saved});

  @override
  State<PostInteractions> createState() => _PostInteractionsState(
      currentUserid: this.userid,
      commentscount: this.comments,
      likecount: this.likes.values.where((element) => element == true).length,
      likes: this.likes,
      postid: this.postid,
      saved: this.saved);
}

class _PostInteractionsState extends State<PostInteractions> {
  final String currentUserid;
  final String postid;
  int likecount;
  int commentscount;
  Map likes;
  Map saved;
  bool isliked = false;
  bool isSaved = false;
  _PostInteractionsState(
      {required this.currentUserid,
      required this.likecount,
      required this.commentscount,
      required this.likes,
      required this.postid,
      required this.saved});
  handleLikePost() {
    bool _isliked = likes[currentUserid] == true;
    if (_isliked) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .update({'likes.$currentUserid': false});
      setState(() {
        likecount -= 1;
        isliked = false;
        likes[currentUserid] = false;
      });
    } else if (!_isliked) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .update({'likes.$currentUserid': true});
      setState(() {
        likecount += 1;
        isliked = true;
        likes[currentUserid] = true;
      });
    }
  }

  handleSavePost() {
    bool _issaved = saved[currentUserid] == true;
    if (_issaved) {
      DatabaseService(uid: currentUserid).deleteunsaved(postid: postid);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .update({'saved.$currentUserid': false});
      setState(() {
        isSaved = false;
        saved[currentUserid] = false;
      });
    } else if (!_issaved) {
      DatabaseService(uid: currentUserid).addsavedData(postid: postid);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .update({'saved.$currentUserid': true});
      setState(() {
        isSaved = true;
        saved[currentUserid] = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isliked = (likes[currentUserid] == true);
      isSaved = (saved[currentUserid] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).backgroundColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                enabledMouseCursor: SystemMouseCursors.click,
                textStyle: const TextStyle(
                  fontSize: 10,
                ),
                //Set the background color

                primary: Colors.white,
                //Set the foreground (text + icon) color
                onPrimary: Theme.of(context).buttonColor,
                elevation: 0,
                //Set the padding on all sides to 30px
                padding: const EdgeInsets.all(7.0),
              ),
              onPressed: handleLikePost,
              icon: isliked
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red[900],
                      size: 20,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),
              label: Text(likecount.toString()),
            ),
          ),
          // const SizedBox(
          //   width: 7,
          // ),
          VerticalDivider(
            color: Theme.of(context).buttonColor,
            indent: 10,
            endIndent: 1,
            thickness: 1,
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).backgroundColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                enabledMouseCursor: SystemMouseCursors.click,
                textStyle: const TextStyle(
                  fontSize: 10,
                ),
                //Set the background color
                primary: Colors.white,
                //Set the foreground (text + icon) color
                onPrimary: Theme.of(context).buttonColor,
                elevation: 0,
                padding: const EdgeInsets.all(7.0),
              ),
              onPressed: () { Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPage(
                      postid: postid,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );},
              icon: const Icon(Icons.comment),
              label: Text(commentscount.toString()),
            ),
          ),
          VerticalDivider(
            color: Theme.of(context).buttonColor,
            indent: 10,
            endIndent: 1,
            thickness: 1,
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).backgroundColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                enabledMouseCursor: SystemMouseCursors.click,
                textStyle: const TextStyle(
                  fontSize: 10,
                ),
                //Set the background color
                primary: Colors.white,
                //Set the foreground (text + icon) color
                onPrimary: Theme.of(context).buttonColor,
                elevation: 0,
                //Set the padding on all sides to 30px
                padding: const EdgeInsets.all(7.0),
              ),
              onPressed:  handleSavePost,
              icon: isSaved
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
              label: isSaved ? const Text("Saved") : const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
