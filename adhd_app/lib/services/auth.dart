import 'package:adhd_app/model/auth_user.dart';
import 'package:adhd_app/services/database.dart';
import 'package:adhd_app/widgets/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:adhd_app/model/auth_user.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  AuthUser? _userFromFirebase(User? user) {
    return user != null
        ? AuthUser(
            user.uid,
            user.email,
            null,
            null,
            null,
            null,
          )
        : null;
  }

  Stream<AuthUser?> get user {
    return _auth.authStateChanges().map(
          (User? user) => _userFromFirebase(user),
        );
  }

  Future<model.AuthUser> getUserDetails() async {
    DocumentSnapshot documentsnapshot =
        await _firestor.collection('users').doc(_auth.currentUser!.uid).get();
    return model.AuthUser.fromSnap(documentsnapshot);
  }

  Future changePassword({required String newPassword}) async {
    try {
      final user = _auth.currentUser!;
      await user.updatePassword(newPassword);
      // FirebaseAuth.instance.signOut();
      return true;
    } catch (error) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      /* The buildcontext will be used to display a snackbar, and is going to help us in storing user data in firebase firestore */
      {required String email,
      required String password,
      required BuildContext context,
      required String firstname,
      required String lastname,
      required int age,
      required String gender}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      // create a new document for the user with the uid
      // create an  instance of the created class
      await DatabaseService(uid: user!.uid)
          .updateUserData(firstname, lastname, age, gender);
      return true;
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!);
      return e.message;
    }
    // return _userFromFirebase(result.user);
  }

  Future loginWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return true;
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!);
      return null;
    }
    // return _userFromFirebase(result.user);
  }

  Future<void> showEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      // showSnackBar(context, 'Email Verfication has been sent!');
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!);
    }
  }

  Future<int> signInWithGoogle(
      {required BuildContext context,
      String? firstname,
      String? lastname,
      int? age,
      String? gender}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            await DatabaseService(uid: user.uid)
                .updateUserData(firstname!, lastname!, age!, gender!);
          }
        }
        // showSnackBar(context, 'Logged In With Google Successfully!');
      }

      return 1;
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!);
      return 0;
    }
  }

  Future<int> signInWithFacebook(
      {required BuildContext context,
      String? firstname,
      String? lastname,
      int? age,
      String? gender}) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await DatabaseService(uid: user.uid)
              .updateUserData(firstname!, lastname!, age!, gender!);
        }
      }
      // showSnackBar(context, 'Logged In With Facebook Successfully!');
      return 1;
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!); // Displaying the error message
      return 0;
    }
  }

  // Future getCurrentUser() async {
  //   return await _auth.currentUser;
  // }

  Future logout() async {
    await _auth.signOut();
  }
}
