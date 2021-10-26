import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Models/m.dart';
import 'package:driver/Screens/changePassword.dart';
import 'package:driver/Screens/slider.dart';
import 'package:driver/Widgets/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// profile screen
///
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final hidePassword = <Widget>[];
  bool isLoad = false;
  bool isShowPassword = false;
  List<UserModel> userList = [];
  final _auth = FirebaseAuth.instance;
  String email = "", profileUrl, name = "", password = "", phone = "", id;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  // getUser() async {
  //   final User user = _auth.currentUser;
  //   final uid = user.uid;
  //   var value = (await FirebaseFirestore.instance
  //       .collection("Drivers Profile")
  //       .doc(uid)
  //       .get());
  //   email = value.data()['email'];
  //   name = value.data()['fullName'];
  //   profileUrl = value.data()['profileUrl'];
  //   password = value.data()['password'];
  //   phone = value.data()['phone'];
  //   id = value.data()['uid'];
  //   print(email);
  //   print(name);
  //   print(profileUrl);
  //   print(password);
  //   print(phone);
  //   print(id);
  // }

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
    // for (var i = 0; i < password.length; i++) {
    //   hidePassword.add(HidePasswordItem());
    // }
    return Scaffold(
      key: _scaffold,

      ///
      /// drawer
      ///
      endDrawer: DrawerSlider(),
      backgroundColor: Color(0xffEFF2F3),

      ///
      /// app bar
      ///
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,

                  ///
                  /// user image
                  ///
                  image: AssetImage(
                    'assets/profile_header_bg@3x.png',
                  ),
                )),
              ),
              Positioned(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, right: 30, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              ///
                              /// pop or close current screen
                              ///
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined,
                                color: Colors.white)),
                        InkWell(
                            onTap: () {
                              ///
                              /// opnen slide menu or drawer or slider
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

                  ///
                  /// user image container
                  ///
                  Container(
                      child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ///
                      /// size of user image
                      ///
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
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 47,
                                    backgroundImage:
                                        NetworkImage('${profileUrl}')))),
                      )
                    ],
                  )),
                ],
              ))
            ],
          )),

      ///
      /// body
      ///
      body: isLoad
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 40),

                        ///
                        /// user name text like حمزه محمد حسن
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

                    ///
                    /// white card container
                    ///
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      /// whatApp text or رقم الواتس اب
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ///
                                      /// password show and hide
                                      ///
                                      Container(
                                        child: Row(
                                            children: List.generate(
                                                password.length,
                                                (index) => HidePasswordItem())
                                            //  [
                                            //   Icon(
                                            //     Icons.circle,
                                            //     size: 10,
                                            //     color: Color(0xff8D8D8D),
                                            //   ),
                                            //   SizedBox(
                                            //     width:
                                            //         MediaQuery.of(context)
                                            //                 .size
                                            //                 .width *
                                            //             0.01,
                                            //   ),
                                            //   Icon(Icons.circle,
                                            //       size: 10,
                                            //       color: Color(0xff8D8D8D)),
                                            //   SizedBox(
                                            //     width:
                                            //         MediaQuery.of(context)
                                            //                 .size
                                            //                 .width *
                                            //             0.01,
                                            //   ),
                                            //   Icon(Icons.circle,
                                            //       size: 10,
                                            //       color: Color(0xff8D8D8D)),
                                            //   SizedBox(
                                            //     width:
                                            //         MediaQuery.of(context)
                                            //                 .size
                                            //                 .width *
                                            //             0.01,
                                            //   ),
                                            //   Icon(
                                            //     Icons.circle,
                                            //     size: 10,
                                            //     color: Color(0xff8D8D8D),
                                            //   ),
                                            //   SizedBox(
                                            //     width:
                                            //         MediaQuery.of(context)
                                            //                 .size
                                            //                 .width *
                                            //             0.01,
                                            //   ),
                                            //   Icon(
                                            //     Icons.circle,
                                            //     size: 10,
                                            //     color: Color(0xff8D8D8D),
                                            //   ),
                                            //   SizedBox(
                                            //     width:
                                            //         MediaQuery.of(context)
                                            //                 .size
                                            //                 .width *
                                            //             0.01,
                                            //   ),
                                            //   Icon(
                                            //     Icons.circle,
                                            //     size: 10,
                                            //     color: Color(0xff8D8D8D),
                                            //   ),
                                            // ],
                                            ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ///
                                      /// password text or كلمة المرور
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
                                  print(
                                      '////////////////////////////////////////////');
                                  print(password);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePassword()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 5, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Color(0xffDDB860))),
                                  child: Text(
                                    'كلمة المرور',
                                    style: TextStyle(
                                        color: Color(0xffDDB860),
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
                  ],
                ),
              ),
            ),
    );
  }
}
