import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:driver/Screens/createAccount.dart';
import 'package:flutter/material.dart';

///
/// whatApp code class
///
class WhatAppCode extends StatefulWidget {
  @override
  _WhatAppCodeState createState() => _WhatAppCodeState();
}

class _WhatAppCodeState extends State<WhatAppCode> {
  var _tip;
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
          Container(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  ///
                  /// back arrow
                  child: Image.asset('assets/chevron_right.png'))),
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color(0xffEFF2F3)),
                  child: Column(
                    children: [
                      ///
                      /// login header logo
                      ///
                      Container(
                        child: Image.asset('assets/otp_ic.png'),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25, bottom: 35),
                        child: Column(
                          children: [
                            ///
                            /// confirmation slot or شيغرة التأكيد text
                            ///
                            Text(
                              'شيغرة التأكيد',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MEDIUM',
                                  fontSize: 17),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),

                            ///
                            ///الرجا إدخال الرمز المرسل على واتس اب الخاص بك or
                            ///Please enter the code sent on your WhatsApp
                            ///
                            Text(
                              'الرجا إدخال الرمز المرسل على واتس اب الخاص بك',
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
                /// white container
                ///
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,

                      ///
                      /// top rounded container
                      ///
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ///
                            /// 1st code
                            ///
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),

                            ///
                            /// 2nd code
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),

                            ///
                            /// 3rd code
                            ///
                            Expanded(
                              child: Container(
                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),

                            ///
                            /// 4th code
                            ///
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),

                            ///
                            /// 5th code
                            ///
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),

                            ///
                            /// 6th code
                            ///
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffEF4A8E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide(
                                            color: Colors.black45,
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.023,
                      ),

                      ///
                      /// confirm button or  تأكيد
                      ///
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccount()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 11),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffEF4A8E),
                              borderRadius: BorderRadius.circular(27)),
                          child: Center(
                              child: Text(
                            'تأكيد',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MEDIUM',
                                fontSize: 18),
                          )),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///
                            /// إعادة إرسال or resend text
                            ///
                            Text(
                              'إعادة إرسال',
                              style: TextStyle(
                                  color: Color(0xffDDB860),
                                  fontFamily: 'MEDIUM'),
                            ),

                            ///
                            /// لم يصلك الرمز؟ or Didn't get the code?
                            ///
                            Text(
                              'لم يصلك الرمز؟ ',
                              style: TextStyle(
                                  color: Color(0xff8D8D8D),
                                  fontFamily: 'MEDIUM'),
                            ),
                          ],
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
