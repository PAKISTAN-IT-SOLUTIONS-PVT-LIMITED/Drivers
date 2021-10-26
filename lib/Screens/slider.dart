import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Screens/profile.dart';
import 'package:driver/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerSlider extends StatefulWidget {
  @override
  _DrawerSliderState createState() => _DrawerSliderState();
}

class _DrawerSliderState extends State<DrawerSlider> {
  final _auth = FirebaseAuth.instance;
  bool isActiveColor1 = false;
  bool isActiveColor2 = false;
  String profileUrl, name = "";

  currentUser() async {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('Drivers Profile').doc(uid).get().then((result) {
      setState(() {
        name = result.data()['fullName'];
        profileUrl = result.data()['profileUrl'];
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
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 20, bottom: 30, top: 35),
            decoration: BoxDecoration(color: Color(0xffEF4A8E)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        // pop drawer screen
                        Navigator.pop(context);
                      },
                      // back arrow icon of drawer or slider
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // user profile
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 38,
                            backgroundImage: NetworkImage('${profileUrl}')),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                ///
                /// user name like hamza Muhammad hassan
                ///
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'MEDIUM',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///
          /// white expanded container of slider or drawer
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      if (isActiveColor1 == true) {
                        isActiveColor1 = false;
                      } else {
                        isActiveColor1 = true;
                      }
                      setState(() {});
                    },

                    ///
                    /// Profile personly الملف الشخصى
                    ///
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        color:
                            isActiveColor1 ? Colors.white : Color(0xffF8F1DF),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('الملف الشخصى',
                                style: TextStyle(
                                    fontFamily: 'MEDIUM', fontSize: 15)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            // user icon
                            Image.asset('assets/usre_ic.png')
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },

                    ///
                    /// logout تسجيل خروج
                    ///
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: isActiveColor2 ? Colors.white : Color(0xffF8F1DF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('تسجيل خروج',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'MEDIUM')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Image.asset('assets/logout_ic.png')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
