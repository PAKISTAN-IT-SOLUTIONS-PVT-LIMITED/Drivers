import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Models/m.dart';
import 'package:driver/Models/model.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Screens/setNewPassword.dart';
import 'package:driver/Widgets/password.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var use;
  var user, result;
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  var userEmail, currentPassword, userId, findedEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      /// main body
      ///
      body: SafeArea(
        child: Container(
          color: Color(0xffEFF2F3),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color(0xffEFF2F3)),
                    child: Column(
                      children: [
                        ///
                        /// login header logo
                        ///
                        Container(
                          padding: EdgeInsets.only(top: 80, bottom: 40),
                          child: Image.asset('assets/login_logo.png'),
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// white expanded container
                  ///
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        ///
                        /// email text form field or الايميل
                        ///
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'الايميل مطلوب';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidate: true,
                                controller: email,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: BorderSide(
                                          color: Color(0xffC5C5C5),
                                        ))),
                              ),
                            ),
                            Positioned(
                              right: 25,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.white,
                                child: Text('الايميل',
                                    style: TextStyle(
                                        color: Color(0xffC5C5C5),
                                        fontFamily: 'MEDIUM',
                                        fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        ///
                        /// verify email button or تحقق
                        ///
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState.validate()) {
                              result = await FirebaseFirestore.instance
                                  .collection("Drivers Profile")
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((element) {
                                  userEmail = element['email'];
                                  // var uid = element['uid'];
                                  if (userEmail == email.text) {
                                    toastMsg(
                                        'تم التحقق من الايميل ', Colors.green);
                                    FirebaseFirestore.instance
                                        .collection("Drivers Profile")
                                        .where("email", isEqualTo: userEmail)
                                        .snapshots()
                                        .listen((event) {
                                      event.docs.forEach((element) async {
                                        print(
                                            '======================================');
                                        userId = element['uid'];
                                        currentPassword = element['password'];
                                        findedEmail = element['email'];
                                        print(userId);
                                        print(findedEmail);
                                        print(currentPassword);
                                        print('Successfully');

                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString(
                                            "userId", userId);
                                        sharedPreferences.setString(
                                            "findedEmail", findedEmail);
                                        sharedPreferences.setString(
                                            "currentPassword", currentPassword);

                                        _auth.signInWithEmailAndPassword(
                                            email: findedEmail,
                                            password: currentPassword);
                                      });
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewPassword()));
                                  }
                                });
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color(0xffEF4A8E),
                                borderRadius: BorderRadius.circular(27)),
                            child: Center(
                                child: Text(
                              'تحقق',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'MEDIUM',
                                  fontSize: 16),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
