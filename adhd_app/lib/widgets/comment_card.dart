import 'package:adhd_app/widgets/time_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  String uid;
  String username;
  dynamic times;
  String comment;
  String postid;
  String cid;
  String gender;
  Map likes;

  CommentCard(
      {Key? key,
      required this.uid,
      required this.cid,
      required this.postid,
      required this.username,
      required this.times,
      required this.gender,
      required this.comment,
      required this.likes})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  // String gender = "";
  bool isliked = false;
  int likecount = 0;

  @override
  void initState() {
    // getUserGender();

    setState(() {
      isliked = (widget.likes[widget.uid] == true);
      likecount =
          widget.likes.values.where((element) => element == true).length;
    });
    super.initState();
  }

  handleLikeComment() {
    bool _isliked = widget.likes[widget.uid] == true;
    if (_isliked) {
      FirebaseFirestore.instance
          .collection('comments')
          .doc(widget.postid)
          .collection('postcomments')
          .doc(widget.cid)
          .update({'commentlikes.${widget.uid}': false});
      setState(() {
        likecount -= 1;
        isliked = false;
        widget.likes[widget.uid] = false;
      });
    } else if (!_isliked) {
      FirebaseFirestore.instance
          .collection('comments')
          .doc(widget.postid)
          .collection('postcomments')
          .doc(widget.cid)
          .update({'commentlikes.${widget.uid}': true});
      setState(() {
        likecount += 1;
        isliked = true;
        widget.likes[widget.uid] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 15,
                      backgroundImage: widget.gender == "Male"
                          ? const AssetImage('assets/images/aboy.png')
                          : widget.gender == "Female"
                              ? const AssetImage('assets/images/agirl.png')
                              : const AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.username,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        TimeFormat(sortTime: widget.times),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Text(
                      widget.comment,
                      // ignore: unnecessary_const
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                )
              ],
            ),
            SizedBox.fromSize(
              size: const Size(56, 56),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    splashColor: Colors.red[900],
                    onTap: () {
                      handleLikeComment();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isliked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red[900],
                                size: 20,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 20,
                              ),
                        Text(
                          likecount.toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
