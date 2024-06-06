import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  //takes params name,email....
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        //goes insd users ,userid and sets
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}
