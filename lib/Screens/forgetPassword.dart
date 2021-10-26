import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Models/m.dart';
import 'package:driver/Models/model.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Widgets/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      ///
                      /// new password text form field or كلمة مرور جديدة
                      ///
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: newPassword,
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
                              padding: EdgeInsets.only(left: 8),
                              color: Colors.white,
                              child: Text('كلمة مرور جديدة',
                                  style: TextStyle(
                                      color: Color(0xffC5C5C5),
                                      fontFamily: 'MEDIUM',
                                      fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      ///
                      /// change password button or  تغيير كلمة المرور
                      ///
                      InkWell(
                        onTap: () async {
                          result = await FirebaseFirestore.instance
                              .collection("Drivers Profile")
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs.forEach((element) {
                              userEmail = element['email'];
                              // var uid = element['uid'];
                              if (userEmail == email.text) {
                                
                                FirebaseFirestore.instance
                                    .collection("Drivers Profile")
                                    .where("email", isEqualTo: userEmail)
                                    .snapshots()
                                    .listen((event) {
                                  event.docs.forEach((element) {
                                    print(
                                        '======================================');
                                    userId = element['uid'];
                                    currentPassword = element['password'];
                                    findedEmail = element['email'];
                                    print(userId);
                                    print(findedEmail);
                                    print(currentPassword);
                                    print('Successfully');
                                  });
                                });
                                
                              } 
                              print('///////////////////////////////////////////');
                              print(findedEmail);
                              print(currentPassword);
                            });
                          });

                          // print(currentPassword);
                          // final cred = EmailAuthProvider.credential(
                          //     email: userEmail, password: currentPassword);
                          // user.reauthenticateWithCredential(cred).then((value) {
                          //   user.updatePassword(newPassword.text).then((_) {
                          //     print('Successfully');
                          //     FirebaseFirestore.instance
                          //         .collection("Drivers Profile")
                          //         .doc(userId)
                          //         .update({'password': newPassword.text});
                          //   }).catchError((error) {
                          //     print(error);
                          //   });
                          // });

                          ///
                          /// navigate to login screen
                          ///
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => Login()));

                          // FirebaseFirestore.instance
                          //     .collection("Drivers Profile")
                          //     .doc(userId)
                          //     .update({'password': newPassword.text});

                          // final user = await FirebaseAuth.instance.currentUser;
                          // final cred = EmailAuthProvider.credential(
                          //     email: userEmail, password: currentPassword);

                          // user.reauthenticateWithCredential(cred).then((value) {
                          //   user.updatePassword(newPassword.text).then((_) {
                          //     print('Successfully');
                          //     FirebaseFirestore.instance
                          //         .collection("Drivers Profile")
                          //         .doc(userId)
                          //         .update({'password': newPassword.text});
                          //   }).catchError((error) {
                          //     print(error);
                          //   });
                          // }).catchError((err) {});
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 12, top: 8),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffEF4A8E),
                              borderRadius: BorderRadius.circular(27)),
                          child: Center(
                              child: Text(
                            'تغيير كلمة المرور',
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
    );
  }
}
