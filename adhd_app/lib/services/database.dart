import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  // the unique user id to connect firestore with firebase.
  final String uid;
  String username = "firstname";

  DatabaseService({required this.uid});

  // Methods used to interact with the firestore database.
  // collection reference (read/write from it).
  // Each user is gonna have a document in this collection.
  // firestore database is connected with firebase users through the unique id formed by the firebase for each user.
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  // we are going to use this function twice.
  // 1: when we first sign up a new user.
  // 2: when we go to the settings panel and update that data.
  // get the reference to a specific document and update that data.
  Future updateUserData(
      String firstname, String lastname, int age, String gender) async {
    // if that doc doesn't exist in the firestore , then it will be created by this line of code.
    // created a reference to a specific doc and them set the required data in it.
    // to set the data, create a map.
    return await userCollection.doc(uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'gender': gender,
    });
  }

  String postid = const Uuid().v1();

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future updatePostsData(String caption, String tag, String? useremail) async {
    final currentUserData =
        await FirebaseFirestore.instance.doc('/users/' + uid).get();

    username = currentUserData['firstname'];
    return await postsCollection.doc(postid).set({
      'caption': caption,
      'tag': tag,
      'uid': uid,
      'postid': postid,
      'username': username,
      'useremail': useremail,
      'likes': {},
      'saved': {},
      'comments': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  String commentid = const Uuid().v4();
  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  Future addComment(String postid, String comment, String currentuserid,
      String gender) async {
    DocumentSnapshot currentuser =
        await userCollection.doc(currentuserid).get();

    await commentsCollection
        .doc(postid)
        .collection('postcomments')
        .doc(commentid)
        .set({
      'cid': commentid,
      'comment': comment,
      'commenter': '${currentuser['firstname']} ${currentuser['lastname']}',
      'commenterid': currentuserid,
      'commentlikes': {},
      'time': FieldValue.serverTimestamp(),
      'gender': currentuser['gender']
    });
  }

  Future addUsersData(String caption, String tag, String? useremail) async {
    final currentUserData =
        await FirebaseFirestore.instance.doc('/users/' + uid).get();

    username = currentUserData['firstname'];

    return await userCollection.doc(uid).collection('posts').doc(postid).set({
      'caption': caption,
      'tag': tag,
      'uid': uid,
      'postid': postid,
      'username': username,
      'useremail': useremail,
      'likes': {},
      'saved': {},
      'comments': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future addsavedData({required String postid}) async {
    DocumentSnapshot snap =
        await userCollection.doc(uid).collection('saved_posts').doc(uid).get();
    // List savedPosts = (snap.data()! as dynamic)['postids'];

    if (snap.exists) {
      return await userCollection
          .doc(uid)
          .collection('saved_posts')
          .doc(uid)
          .update({
        'postids': FieldValue.arrayUnion([postid]),
      });
    } else {
      return await userCollection
          .doc(uid)
          .collection('saved_posts')
          .doc(uid)
          .set({
        'postids': FieldValue.arrayUnion([postid]),
      });
    }
  }

  Future deleteunsaved({required String postid}) async {
    DocumentSnapshot snap =
        await userCollection.doc(uid).collection('saved_posts').doc(uid).get();
    // List savedPosts = (snap.data()! as dynamic)['postids'];

    if (snap.exists) {
      return await userCollection
          .doc(uid)
          .collection('saved_posts')
          .doc(uid)
          .update({
        'postids': FieldValue.arrayRemove([postid]),
      });
    } else {
      return await userCollection
          .doc(uid)
          .collection('saved_posts')
          .doc(uid)
          .set({
        'postids': FieldValue.arrayRemove([postid]),
      });
    }
  }

  Future getSavedPosts({required String userid}) async {
    DocumentSnapshot snapshot =
        await userCollection.doc(uid).collection('saved_posts').doc(uid).get();
    return await snapshot['postids'];
  }

  Future getPostCommented({required String postid}) async {
    DocumentSnapshot dSnap = await postsCollection.doc(postid).get();
    return dSnap.data();
  }

  Future getUserGender({required String userid}) async {
    DocumentSnapshot dSnap = await userCollection.doc(userid).get();
    return await dSnap['gender'];
  }

  Future getCommenterId({required String cid, required String postid}) async {
    DocumentSnapshot dSnap = await commentsCollection
        .doc(postid)
        .collection("postcomments")
        .doc(cid)
        .get();
    return await dSnap['commenterid'];
  }
}
