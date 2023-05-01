import 'package:adhd_app/screens/tabs/feed/postdetails.dart';
import 'package:adhd_app/screens/tabs/feed/postinteractions.dart';
import 'package:adhd_app/screens/tabs/feed/userdetails.dart';
import 'package:adhd_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/comment_card.dart';
import '../../authenticate/wrapper.dart';

const List<Widget> order = <Widget>[
  Text('Recent'),
  Text('Liked'),
];

class CommentsPage extends StatefulWidget {
  String postid;
  CommentsPage({Key? key, required this.postid}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final List<bool> _selectedOrder = <bool>[true, false];
  final List<String> _selectedOrderValue = <String>['time', 'commentlikes'];
  bool vertical = false;
  TextEditingController commentsTEC = TextEditingController();
  String currentuserid = FirebaseAuth.instance.currentUser!.uid;
  String username = '';
  String useremail = '';
  dynamic timestamp;
  String caption = '';
  String tag = '';
  String postownerid = '';
  int commentscount = 0;
  Map likes = {};
  Map saved = {};
  late String comment;
  String Orderedby = 'time';
  String gender = '';

  @override
  void dispose() {
    commentsTEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getPost();
    Future.delayed(Duration(seconds: 2));
    getUserGender();
    super.initState();
  }

  Future getPost() async {
    DatabaseService(uid: currentuserid)
        .getPostCommented(postid: widget.postid)
        .then((value) {
      setState(() {
        username = value['username'];
        useremail = value['useremail'];
        tag = value['tag'];
        timestamp = value['timestamp'];
        commentscount = value['comments'];
        caption = value['caption'];
        likes = value['likes'];
        saved = value['saved'];
        postownerid = value['uid'];
      });
    });
  }

  getUserGender() {
    DatabaseService(uid: currentuserid)
        .getUserGender(userid: currentuserid)
        .then((value) {
      setState(() {
        gender = value;
        print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Wrapper(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Post(),
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Comments',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ToggleButtons with a single selection.
                            Text(
                              'Most: ',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 20,
                              child: ToggleButtons(
                                direction:
                                    vertical ? Axis.vertical : Axis.horizontal,
                                onPressed: (int index) {
                                  setState(() {
                                    // The button that is tapped is set to true, and the others to false.
                                    for (int i = 0;
                                        i < _selectedOrder.length;
                                        i++) {
                                      _selectedOrder[i] = i == index;
                                    }
                                    Orderedby = _selectedOrderValue[index];
                                  });
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                selectedBorderColor:
                                    Theme.of(context).primaryColorDark,
                                selectedColor: Colors.white,
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                color: Theme.of(context).primaryColorDark,
                                constraints: const BoxConstraints(
                                  minHeight: 20.0,
                                  minWidth: 65.0,
                                ),
                                isSelected: _selectedOrder,
                                children: order,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('comments')
                        .doc(widget.postid)
                        .collection('postcomments')
                        .orderBy(Orderedby, descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LinearProgressIndicator();
                      }
                      if (!snapshot.hasData) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return
                                // Text(
                                //     snapshot.data!.docs[index].get('comment'));
                                CommentCard(
                              uid:
                                  snapshot.data!.docs[index].get('commenterid'),
                              username:
                                  snapshot.data!.docs[index].get('commenter'),
                              times: snapshot.data!.docs[index].get('time'),
                              comment:
                                  snapshot.data!.docs[index].get('comment'),
                              postid: widget.postid,
                              cid: snapshot.data!.docs[index].get('cid'),
                              likes: snapshot.data!.docs[index]
                                  .get('commentlikes'),
                              gender: snapshot.data!.docs[index].get('gender'),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 190.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: TextField(
                            // onChanged: (val) {setState(() {

                            // });},
                            textCapitalization: TextCapitalization.sentences,
                            controller: commentsTEC,
                            style: TextStyle(
                              fontSize: 15.0,
                              color:
                                  Theme.of(context).textTheme.headline6!.color,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Write your comment...",
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                            ),
                            maxLines: null,
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              setState(() {
                                comment = commentsTEC.text;
                                commentscount += 1;
                              });

                              FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(widget.postid)
                                  .update({'comments': commentscount});
                              DatabaseService(uid: currentuserid).addComment(
                                  widget.postid,
                                  comment,
                                  currentuserid,
                                  gender);
                              commentsTEC.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget commentcard(String uid, String username, dynamic times, String comment,
  //     String postid, String cid, Map likes) {
  //   bool isliked = (likes[uid] == true);
  //   int likecount = likes.values.where((element) => element == true).length;
  //   return Container(
  //     height: 80,
  //     margin: const EdgeInsets.all(1),
  //     padding: const EdgeInsets.all(3),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //                 // GenderAvatar(uid: uid),
  //                 const SizedBox(
  //                   width: 5,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       username,
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 1,
  //                     ),
  //                     TimeFormat(sortTime: times),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               // ignore: prefer_const_literals_to_create_immutables
  //               children: <Widget>[
  //                 Text(
  //                   comment,
  //                   // ignore: unnecessary_const
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w300,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 2,
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //         SizedBox.fromSize(
  //           size: const Size(56, 56),
  //           child: ClipOval(
  //             child: Material(
  //               color: Colors.white,
  //               child: InkWell(
  //                 splashColor: Colors.red[900],
  //                 onTap: () {
  //                   bool _isliked = likes[uid] == true;
  //                   if (_isliked) {
  //                     FirebaseFirestore.instance
  //                         .collection('comments')
  //                         .doc(widget.postid)
  //                         .collection('postcomments')
  //                         .doc(cid)
  //                         .update({'commentlikes.${uid}': false});
  //                     setState(() {
  //                       likecount -= 1;
  //                       isliked = false;
  //                       likes[uid] = false;
  //                     });
  //                   } else if (!_isliked) {
  //                     FirebaseFirestore.instance
  //                         .collection('comments')
  //                         .doc(widget.postid)
  //                         .collection('postcomments')
  //                         .doc(cid)
  //                         .update({'commentlikes.${uid}': true});
  //                     setState(() {
  //                       likecount += 1;
  //                       isliked = true;
  //                       likes[uid] = true;
  //                     });
  //                   }
  //                 },
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     isliked
  //                         ? Icon(
  //                             Icons.favorite,
  //                             color: Colors.red[900],
  //                             size: 20,
  //                           )
  //                         : const Icon(
  //                             Icons.favorite_border,
  //                             size: 20,
  //                           ),
  //                     Text(
  //                       likecount.toString(),
  //                       style: const TextStyle(fontSize: 10),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget Post() {
    return FutureBuilder(
      future: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .getPostCommented(postid: widget.postid),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            color: Theme.of(context).backgroundColor,
            elevation: 0,
            child: Container(
              color: Theme.of(context).backgroundColor,
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserDetails(
                    uid: postownerid,
                    username: username,
                    useremail: useremail,
                    time: timestamp,
                  ),
                  Divider(
                    color: Theme.of(context).buttonColor,
                    thickness: 0.1,
                  ),
                  PostDetails(
                    caption: caption,
                    tag: tag,
                  ),
                  // Divider(
                  //   color: Colors.grey[5],
                  // ),
                  PostInteractions(
                    userid: FirebaseAuth.instance.currentUser!.uid,
                    comments: commentscount,
                    likes: likes,
                    postid: widget.postid,
                    saved: saved,
                  ),
                ],
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      }),
    );
  }
}
