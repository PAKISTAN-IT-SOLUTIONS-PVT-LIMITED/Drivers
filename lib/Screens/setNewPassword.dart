import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Models/m.dart';
import 'package:driver/Models/model.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Widgets/password.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var use;
  var user, result;
  final _auth = FirebaseAuth.instance;
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
                      /// new pasword text form field or كلمة مرور جديدة
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
                              padding: EdgeInsets.symmetric(horizontal: 8),
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      ///
                      /// change password button or تغيير كلمة المرور
                      ///
                      InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          String password =
                              sharedPreferences.getString("currentPassword");
                          print(_auth.currentUser.uid);
                          print(_auth.currentUser.email);
                          print(password);
                          final user = FirebaseAuth.instance.currentUser;
                          // print(user);
                          final cred = EmailAuthProvider.credential(
                              email: user.email, password: password);
                          print(cred);
                          if (password == newPassword.text)
                            toastMsg('حسابك موجود بالفعل مع كلمة المرور هذه',
                                Colors.red);
                          else
                            user
                                .reauthenticateWithCredential(cred)
                                .then((value) {
                              user.updatePassword(newPassword.text).then((_) {
                                FirebaseFirestore.instance
                                    .collection("Drivers Profile")
                                    .doc(_auth.currentUser.uid)
                                    .update({'password': newPassword.text});
                                toastMsg(
                                    'تغيير كلمة المرور بنجاح', Colors.green);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              }).catchError((error) {
                                print(error);
                              });
                            });
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          // _auth.signOut();
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
