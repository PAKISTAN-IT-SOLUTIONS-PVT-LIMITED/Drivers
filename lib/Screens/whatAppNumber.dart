import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Screens/order.dart';
import 'package:driver/Screens/whatAppCode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WhatAppNumber extends StatefulWidget {
  @override
  _WhatAppNumberState createState() => _WhatAppNumberState();
}

///
/// whatAppNumber class
///
class _WhatAppNumberState extends State<WhatAppNumber> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  TextEditingController _phone = TextEditingController();
  String phoneCode;
  String phone;
  String sign;


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      /// app bar
      ///
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffEFF2F3),
        elevation: 0.0,
        actions: [
          InkWell(
              onTap: () {
                ///
                /// close or disapper screen
                ///
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      ///
                      /// back icon
                      ///
                      child: Image.asset('assets/chevron_right.png')))),
        ],
      ),

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
                  ///
                  /// full width
                  ///
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color(0xffEFF2F3)),
                  child: Column(
                    children: [
                      ///
                      /// login header logo
                      ///
                      Container(
                        child: Image.asset('assets/signup_mobile_ic.png'),
                      ),

                      ///
                      /// register text or التسجيل
                      ///
                      Container(
                        padding: EdgeInsets.only(top: 25, bottom: 33),
                        child: Column(
                          children: [
                            Text(
                              'التسجيل',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MEDIUM',
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),

                            ///
                            /// أدخل رقم الواتس اب وسنرسل رمز التحقق
                            /// or Enter your WhatsApp number and we will send a verification code
                            ///
                            Text(
                              'أدخل رقم الواتس اب وسنرسل رمز التحقق',
                              style: TextStyle(
                                  color: Color(0xff8D8D8D),
                                  fontFamily: 'MEDIUM'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                ///
                /// white expanded container
                ///
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
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
                      /// mobile number text form field
                      ///
                      Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ///
                                /// country code picker
                                ///
                                // ListTile(
                                //     title: _buildCountryPickerDropdown(
                                //         sortedByIsoCode: true)),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 25,
                            top: -10,
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 15),
                              color: Colors.white,
                              child: Text(
                                'رقم الواتس اب',
                                style: TextStyle(
                                    color: Colors.grey, fontFamily: 'MEDIUM'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),

                      ///
                      /// confirm button or  يكمل
                      ///
                      InkWell(
                        onTap: () async{
                          phone = phoneCode + _phone.text;
                          print(phone.toString());

                                  // print(_phone.text);

                          // print(phone);
                          ///
                          /// navigate to whatApp code
                          ///
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => WhatAppCode()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 11),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffEF4A8E),
                              borderRadius: BorderRadius.circular(27)),
                          child: Center(
                              child: Text(
                            'يكمل',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MEDIUM',
                                fontSize: 18),
                          )),
                        ),
                      ),

                      ///
                      /// click listener on already have an account
                      ///
                      InkWell(
                        onTap: () {
                          ///
                          /// navigate to login screen
                          ///
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },

                        ///
                        /// already have an account or امتلك حساب بالفعل
                        ///
                        child: Container(
                          padding: EdgeInsets.only(top: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'امتلك حساب بالفعل',
                                style: TextStyle(
                                    color: Color(0xffDDB860),
                                    fontFamily: 'MEDIUM'),
                              ),
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
    );
  }

  }
