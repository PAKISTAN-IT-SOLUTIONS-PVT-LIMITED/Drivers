import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:driver/Models/userModel.dart';
import 'package:driver/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// create account class
///
class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  String imgeUrl;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fullName;

  // init hiddenPassword
  bool isHiddenPasword = true;
  PickedFile imageFile = null;
  var downloadUrl;
  Future<void> signup() async {
    if (imageFile != null) {
      var snapshot = await _storage
          .ref()
          .child('users/${DateTime.now()}')
          .putFile(File(imageFile.path));
      downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imgeUrl = downloadUrl;
      });
    } else {
      print('no path is found');
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString("phone");
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    String uid = FirebaseAuth.instance.currentUser.uid;
    fullName = firstName.text +" "+lastName.text;
    await CreateUserAccount().addUser(fullName, email.text,
        password.text, phone, downloadUrl, uid);
    uid = userCredential.user.uid;
    return userCredential;
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Color(0xffEF4A8E)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xffEF4A8E),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xffEF4A8E),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xffEF4A8E),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xffEF4A8E),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      /// body
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  ///
                                  /// pop or disappear current screen
                                  ///
                                  Navigator.pop(context);
                                },

                                ///
                                /// back arrow icon
                                ///
                                child: Image.asset('assets/chevron_right.png')),
                          ],
                        ),
                      ),

                      ///
                      /// login header logo
                      ///
                      Container(
                        child: Stack(clipBehavior: Clip.none, children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffe0e0e0)),
                              child: imageFile == null
                                  ?

                                  ///
                                  /// user icon
                                  ///
                                  Image.asset('assets/user_placeholder.png')
                                  : ClipOval(
                                      child: Image.file(
                                      File(imageFile.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ))),
                          Positioned(
                              left: 0,
                              right: -70,
                              bottom: 0,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    _showChoiceDialog(context);
                                  },
                                  child: Image(

                                      ///
                                      /// camera icon
                                      ///
                                      image:
                                          AssetImage('assets/camera_ic.png')),
                                ),
                              ))
                        ]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ],
                  ),
                ),

                ///
                /// white container
                ///
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      ///
                      /// first name text from field or الاسم الاول
                      ///
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: firstName,
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
                            top: 0,
                            right: 20,
                            child: Container(
                              color: Colors.white,
                              child: Text(' الاسم الاول   ',
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
                      /// family name or اسم العائلته
                      ///
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: lastName,
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
                            right: 20,
                            top: 0,
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                ' اسم العائلته',
                                style: TextStyle(
                                    color: Color(0xffC5C5C5),
                                    fontSize: 13,
                                    fontFamily: 'MEDIUM'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      ///
                      /// email or الايميل
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
                            right: 20,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.only(left: 5, right: 7),
                              color: Colors.white,
                              child: Text(
                                'الايميل',
                                style: TextStyle(
                                    color: Color(0xffC5C5C5),
                                    fontSize: 13,
                                    fontFamily: 'MEDIUM'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      ///
                      /// password text form field or كلمته المرور
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
                                      /// visible and invisible container
                                      ///
                                      child: Image(
                                        image: isHiddenPasword == true
                                            ? AssetImage('assets/eye_off.png')
                                            : AssetImage('assets/eye_on.png'),
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
                            top: 0,
                            right: 20,
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                ' كلمته المرور',
                                style: TextStyle(
                                    color: Color(0xffC5C5C5),
                                    fontSize: 13,
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
                      /// create account container or انشاء حساب
                      ///
                      InkWell(
                        onTap: () {
                          print('ppppppppppppppppppppppppp');
                          getPhone();
                          // getOtp();
                          // try {
                          //   _auth.createUserWithEmailAndPassword(
                          //       email: email.text.toString().trim(),
                          //       password: password.text.toString().trim());
                          // } catch (e) {
                          //   print(e);
                          // }
                          signup();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 6, bottom: 11),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffEF4A8E),
                              borderRadius: BorderRadius.circular(27)),
                          child: Center(
                              child: Text(
                            'انشاء حساب',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MEDIUM',
                                fontSize: 18),
                          )),
                        ),
                      ),

                      ///
                      /// already have an account or امتلك حساب بالفعل
                      ///
                      InkWell(
                        onTap: () {
                          ///
                          /// navigate to login screen
                          ///
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                          print(imageFile.path);
                          // getPath();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 22),
                          child: Text(
                            'امتلك حساب بالفعل',
                            style: TextStyle(
                              fontFamily: 'MEDIUM',
                              fontSize: 15,
                              color: Color(0xffDDB860),
                            ),
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
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  getPath() async {
    if (imageFile != null) {
      var snapshot = await _storage
          .ref()
          .child('users/${DateTime.now()}')
          .putFile(File(imageFile.path));
      downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imgeUrl = downloadUrl;
      });
      print('pppppppppppppppppppppppppppppppp');
      print(imgeUrl.toString());
      print('ppppppppppppppppppppppppppppppp');
    } else {
      print('no path is found');
    }
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    print('pppppppppppppppppppppppppppppp');
    print(pickedFile.path);
    print('pppppppppppppppppppppppppppppp');
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  getPhone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString("phone");
    String a = sharedPreferences.getString("otp");
    print("+${phone}");
  }
}
