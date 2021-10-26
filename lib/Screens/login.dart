import 'package:driver/Models/userModel.dart';
import 'package:driver/Screens/example.dart';
import 'package:driver/Screens/order.dart';
import 'package:driver/Screens/phoneAuth.dart';
import 'package:driver/Screens/phoneGmail.dart';
import 'package:driver/Screens/verifyEmail.dart';
import 'package:driver/Services/auth.dart';
import 'package:driver/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var user;
  bool isEmailValid = false;
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // init hiddenPassword
  FToast fToast;
  bool isHiddenPasword = true;

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
                                cursorColor: Color(0xffEF4A8E),
                                controller: email,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E))),
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
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "الايميل مطلوب";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidate: true,
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
                        /// password text form field or كلمته المرور
                        ///
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: password,
                                obscureText: isHiddenPasword,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          if (isHiddenPasword == true) {
                                            isHiddenPasword = false;
                                          } else {
                                            isHiddenPasword = true;
                                          }
                                          setState(() {});
                                        },

                                        ///
                                        /// visible and invisible icons
                                        ///
                                        child: Image(
                                          image: isHiddenPasword == true
                                              ? AssetImage('assets/eye_off.png')
                                              : AssetImage('assets/eye_on.png'),
                                        )),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E))),
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
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "كلمة المرور مطلوب";
                                  } else if (val.length < 6) {
                                    return "كلمة مرور الأسبوع";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidate: true,
                              ),
                            ),
                            Positioned(
                              right: 25,
                              top: 0,
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  ' كلمته المرور ',
                                  style: TextStyle(
                                      color: Color(0xffC5C5C5),
                                      fontSize: 14,
                                      fontFamily: 'MEDIUM'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),

                        ///
                        /// login button or تسجىل الدخول
                        ///
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState.validate()) {
                              isEmailValid =
                                  EmailValidator.validate(email.text);
                              if (isEmailValid) {
                                user = await _auth.signInWithEmailAndPassword(
                                    email: email.text.trim(),
                                    password: password.text.trim());

                                if (user != null) {
                                  loginToast(
                                      'Login Successfully', Colors.green);

                                  ///
                                  /// navigate to order screen
                                  ///
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Orders()));
                                }
                              } else {
                                toastMsg("تنسيق الايميل غير صالح", Colors.red);
                              }
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
                              'تسجىل الدخول',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'MEDIUM',
                                  fontSize: 16),
                            )),
                          ),
                        ),

                        ///
                        /// forget password نسبت كلمته المرور؟
                        ///
                        InkWell(
                          onTap: () {
                            ///
                            /// navigate to changePassowrd screen
                            ///
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyEmail()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 16, bottom: 35),
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffDDB860),
                                  fontFamily: 'MEDIUM'),
                            ),
                          ),
                        ),

                        ///
                        /// register a new account or تسجيل حساب جدىد
                        ///
                        InkWell(
                          onTap: () {
                            ///
                            /// navigate or call to whatAppNumber screen
                            ///
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Phone()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffEF4A8E)),
                                borderRadius: BorderRadius.circular(27)),
                            child: Center(
                                child: Text(
                              'تسجيل حساب جدىد',
                              style: TextStyle(
                                  color: Color(0xffEF4A8E),
                                  fontSize: 16,
                                  fontFamily: 'MEDIUM'),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        ///
                        /// login with Google container or الدخول مع جوجل
                        ///
                        InkWell(
                          onTap: () async {
                            print('pppppppppppppppppp');
                            user = await signInWithGoogle();

                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            String email =
                                sharedPreferences.getString("userEmail");
                            String name =
                                sharedPreferences.getString("userName");
                            String photo =
                                sharedPreferences.getString("userPhoto");
                            String uId = sharedPreferences.getString("userId");
                            String phone =
                                sharedPreferences.getString("userPhone");
                            String uid = FirebaseAuth.instance.currentUser.uid;
                            print('================================');
                            print(uid);
                            print('================================');

                           
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneGmail()));
                                
                           
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 7, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffC5C5C5)),
                                borderRadius: BorderRadius.circular(27)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'الدخول مع جوجل',
                                  style: TextStyle(
                                      color: Color(0xff3A3235),
                                      fontSize: 16,
                                      fontFamily: 'MEDIUM'),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                Container(

                                    ///
                                    /// google icon
                                    ///
                                    child:
                                        Image.asset('assets/google_icon.png'))
                              ],
                            ),
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
