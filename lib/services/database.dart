import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // the unique user id to connect firestore with firebase.
  final String uid;
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
}
