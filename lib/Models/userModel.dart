import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUserAccount {
  final users = FirebaseFirestore.instance
      .collection('Drivers Profile');

  addUser(String fullName, String email, String password,
      String phone, String profileUrl, String uid) {
    return users.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'profileUrl': profileUrl,
      'uid': uid,
    });
  }
}
