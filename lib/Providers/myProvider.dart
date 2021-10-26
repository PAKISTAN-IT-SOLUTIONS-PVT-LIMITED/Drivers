import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Models/m.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  UserModel userModel;
  List<UserModel> userList = [];
  Future<void> getData() async {
    // var firebaseUser = FirebaseAuth.instance.currentUser.uid;

    List<UserModel> userList1 = [];
    QuerySnapshot querySnapshot = (await FirebaseFirestore.instance
        .collection('Drivers')
        .doc('CCWSNEnKZVFfS9UGDpX5')
        .collection('Create Account').get());

    querySnapshot.docs.forEach((element) {
      userModel = UserModel(
          email: element['email'],
          fullName: element['fullName'],
          password: element['password'],
          phone: element['phone'],
          profile: element['profileUrl'],
          uId: element['uid']);
      userList1.add(userModel);
      userList1 = userList;
    });
  }

  get throwUser {
    return userList;
  }
}
