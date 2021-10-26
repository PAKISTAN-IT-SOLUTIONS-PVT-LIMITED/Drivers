import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Screens/slider.dart';
import 'package:driver/Widgets/password.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool isPreviousHiddenPasword = false;
  bool isNewHiddenPassword = false;
  bool isShowPassword = false;
  final _auth = FirebaseAuth.instance;
  String email = "", profileUrl, name = "", password = "", phone = "", id;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  currentUser() async {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('Drivers Profile').doc(uid).get().then((result) {
      setState(() {
        email = result.data()['email'];
        name = result.data()['fullName'];
        print(result.data()['fullName']);
        phone = result.data()['phone'];
        print(result.data()['phone']);
        password = result.data()['password'];
        print(password.length);
        print(result.data()['password']);
        profileUrl = result.data()['profileUrl'];
        print(result.data()['profileUrl']);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUser();
    currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF2F3),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/profile_header_bg@3x.png',
                  ),
                )),
              ),
              Positioned(
                  // bottom: -20,
                  // left: 120,
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, right: 30, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              ///
                              /// navigate to side menu or drawer or silder
                              ///
                              _scaffold.currentState.openEndDrawer();
                            },

                            ///
                            /// menu icon
                            ///
                            child: Image.asset('assets/menu_ic.png')),
                      ],
                    ),
                  ),
                  Container(
                      child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -20,
                        child: Center(

                            ///
                            /// user image
                            ///
                            child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: NetworkImage('${profileUrl}'),
                          ),
                        )),
                      )
                    ],
                  )),
                ],
              ))
            ],
          )),
      key: _scaffold,

      ///
      /// drawer or slider
      ///
      endDrawer: DrawerSlider(),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 40),

                    ///
                    /// user name text
                    ///
                    child: Text(
                      '${name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'MEDIUM',
                          fontSize: 18),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///
                              /// whatApp row
                              ///
                              Row(
                                children: [
                                  ///
                                  /// whatApp icon
                                  ///
                                  Image.asset('assets/whatsapp_ic.png'),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),

                                  ///
                                  /// whatApp number
                                  ///
                                  Text(
                                    '${phone}',
                                    style: TextStyle(
                                        color: Color(0xff00E676),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  ///
                                  /// whatApp text
                                  ///
                                  Text(
                                    'رقم الواتس اب',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xff8D8D8D),
                                        fontFamily: 'MEDIUM'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  isShowPassword == false
                                      ? Container(
                                          child: Row(
                                              children: List.generate(
                                                  password.length,
                                                  (index) =>
                                                      HidePasswordItem())),
                                        )
                                      : Text('${password}'),
                                ],
                              ),
                              Row(
                                children: [
                                  ///
                                  /// كلمة المرور or password
                                  ///
                                  Text(
                                    'كلمة المرور',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xff8D8D8D),
                                        fontFamily: 'MEDIUM'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// كلمة المرور password button
                        ///
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (isShowPassword == true) {
                                isShowPassword = false;
                              } else {
                                isShowPassword = true;
                              }
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, top: 5, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffDDB860),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffDDB860))),
                              child: Text(
                                'كلمة المرور',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'MEDIUM',
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),

                ///
                /// set new password
                ///
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 14, left: 14, right: 14, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        ///
                        ///  current password text form field or كلمة المرور الحالي
                        ///
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: currentPassword,
                                obscureText: isPreviousHiddenPasword,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          if (isPreviousHiddenPasword == true) {
                                            isPreviousHiddenPasword = false;
                                          } else {
                                            isPreviousHiddenPasword = true;
                                          }
                                          setState(() {});
                                        },

                                        ///
                                        /// visible and invisible icons
                                        ///
                                        child: Image(
                                          image: isPreviousHiddenPasword == true
                                              ? AssetImage('assets/eye_on.png')
                                              : AssetImage(
                                                  'assets/eye_off.png'),
                                        )),
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
                                padding: EdgeInsets.only(left: 5, right: 3),
                                color: Colors.white,
                                child: Text(
                                  'كلمة المرور الحالي',
                                  style: TextStyle(
                                      color: Color(0xffC5C5C5),
                                      fontFamily: 'MEDIUM',
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.013,
                        ),

                        ///
                        /// new password text form field or كلمة المرور جديدة
                        ///
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: newPassword,
                                obscureText: isNewHiddenPassword,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          if (isNewHiddenPassword == true) {
                                            isNewHiddenPassword = false;
                                          } else {
                                            isNewHiddenPassword = true;
                                          }
                                          setState(() {});
                                        },

                                        ///
                                        /// visible and invisible icons
                                        ///
                                        child: Image(
                                          image: isNewHiddenPassword == true
                                              ? AssetImage('assets/eye_on.png')
                                              : AssetImage(
                                                  'assets/eye_off.png'),
                                        )),
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
                                padding: EdgeInsets.only(left: 5),
                                color: Colors.white,
                                child: Text(
                                  'كلمة المرور جديدة',
                                  style: TextStyle(
                                    fontFamily: 'MEDIUM',
                                    fontSize: 14,
                                    color: Color(0xffC5C5C5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///
                              /// Eliminates or يلغي button
                              ///
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Color(0xffDDB860))),
                                    child: Text('يلغي',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xffDDB860),
                                            fontSize: 15,
                                            fontFamily: 'MEDIUM')),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),

                              ///
                              /// confirm or تاكيد button
                              ///
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    print(password);
                                    print(email);
                                    if (currentPassword.text.length > 0 &&
                                        newPassword.text.length > 0) {
                                      final user = await FirebaseAuth
                                          .instance.currentUser;

                                      final cred = EmailAuthProvider.credential(
                                          email: user.email,
                                          password: currentPassword.text);

                                      user
                                          .reauthenticateWithCredential(cred)
                                          .then((value) {
                                        if (currentPassword.text ==
                                            newPassword.text) {
                                          toastMsg(
                                              'نفس كلمة المرور', Colors.red);
                                        } else {
                                          user
                                              .updatePassword(newPassword.text)
                                              .then((_) {
                                            print('Successfully');
                                            FirebaseFirestore.instance
                                                .collection("Drivers Profile")
                                                .doc(_auth.currentUser.uid)
                                                .update({
                                              'password': newPassword.text
                                            });
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }
                                      }).catchError((err) {});
                                    } else {
                                      toastMsg(
                                          'الرجاء إدخال كلمة المرور الحالية وكلمة المرور الجديدة',
                                          Colors.red);
                                    }
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 12),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEF4A8E),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'تاكيد',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontFamily: 'MEDIUM'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
