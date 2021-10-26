import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:driver/Screens/createAccount.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Screens/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController _phone = TextEditingController();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();
  TextEditingController six = TextEditingController();
  String otp;
  String phoneCode;
  String phone;
  String sign;
  TextEditingController phoneController = TextEditingController();
  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CreateAccount()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  ///
  /// mobile number widget
  ///
  showMobilePhoneWidget(context) {
    return ListView(
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
                      height: MediaQuery.of(context).size.height * 0.007,
                    ),

                    ///
                    /// أدخل رقم الواتس اب وسنرسل رمز التحقق
                    /// or Enter your WhatsApp number and we will send a verification code
                    ///
                    Text(
                      'أدخل رقم الواتس اب وسنرسل رمز التحقق',
                      style: TextStyle(
                          color: Color(0xff8D8D8D), fontFamily: 'MEDIUM'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
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
                        ListTile(
                            title: _buildCountryPickerDropdown(
                                sortedByIsoCode: true)),
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
                        style:
                            TextStyle(color: Colors.grey, fontFamily: 'MEDIUM'),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffEF4A8E),
                        padding: EdgeInsets.only(top: 3, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () async {
                      phone = phoneCode + _phone.text;
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString("phone", phone.toString());
                      await _auth.verifyPhoneNumber(
                          phoneNumber: "+${phone}",
                          verificationCompleted: (phoneAuthCredential) async {},
                          verificationFailed: (verificationFailed) {
                            print(verificationFailed);
                          },
                          codeSent: (verificationID, resendingToken) async {
                            setState(() {
                              currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
                              this.verificationID = verificationID;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationID) async {});
                    },
                    child: Text(
                      "يكمل",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontFamily: 'MEDIUM',
                          fontSize: 18),
                    )),
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
                            color: Color(0xffDDB860), fontFamily: 'MEDIUM'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Spacer()
      ],
    );
  }

  ///
  /// otp widget
  ///
  showOtpFormWidget(context) {
    return SafeArea(
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
                            height: MediaQuery.of(context).size.height * 0.007,
                          ),

                          ///
                          ///الرجا إدخال الرمز المرسل على واتس اب الخاص بك or
                          ///Please enter the code sent on your WhatsApp
                          ///
                          Text(
                            'الرجا إدخال الرمز المرسل على واتس اب الخاص بك',
                            style: TextStyle(
                                color: Color(0xff8D8D8D), fontFamily: 'MEDIUM'),
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
                                ///
                                /// goto next field
                                ///
                                textInputAction: TextInputAction.next,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: one,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                                ///
                                /// goto next field
                                ///
                                textInputAction: TextInputAction.next,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: two,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                ///
                                /// goto next field
                                ///
                                textInputAction: TextInputAction.next,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: three,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                                ///
                                /// goto next field
                                ///
                                textInputAction: TextInputAction.next,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: four,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                                ///
                                /// goto next field
                                ///
                                textInputAction: TextInputAction.next,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: five,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                                ///
                                /// all field are done
                                ///
                                textInputAction: TextInputAction.done,

                                ///
                                /// user will enter only one digit
                                ///
                                maxLength: 1,
                                controller: six,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    ///
                                    /// hide letter count from bottom of text form field
                                    ///
                                    counterText: "",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffEF4A8E)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
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
                      onTap: () async {
                        print('pppppppppppppppppppppppppppppp');
                        otp = one.text +
                            two.text +
                            three.text +
                            four.text +
                            five.text +
                            six.text;
                        print(otp.toString());
                        SharedPreferences sharedPreferences1 =
                            await SharedPreferences.getInstance();
                        sharedPreferences1.setString("otp", otp.toString());
                        AuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationID,
                                smsCode: otp.toString());
                        signInWithPhoneAuthCred(phoneAuthCredential);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CreateAccount()));
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
                                color: Color(0xffDDB860), fontFamily: 'MEDIUM'),
                          ),

                          ///
                          /// لم يصلك الرمز؟ or Didn't get the code?
                          ///
                          Text(
                            'لم يصلك الرمز؟ ',
                            style: TextStyle(
                                color: Color(0xff8D8D8D), fontFamily: 'MEDIUM'),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
          ? showMobilePhoneWidget(context)
          : showOtpFormWidget(context),
    );
  }

  ///
  /// country code picker widget
  ///
  _buildCountryPickerDropdown(
      {bool sortedByIsoCode = false, bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.38;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: dropdownButtonWidth,
          child: CountryPickerDropdown(
            //show'em (the text fields) you're in charge now
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            //if you have menu items of varying size, itemHeight being null respects
            //that, IntrinsicHeight under the hood ;).
            itemHeight: null,
            //itemHeight being null and isDense being true doesn't play along
            //well together. One is trying to limit size and other is saying
            //limit is the sky, therefore conflicts.
            //false is default but still keep that in mind.
            isDense: false,
            //if you want your dropdown button's selected item UI to be different
            //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                    country, dropdownSelectedItemWidth)
                : null,
            //initialValue: 'AR',
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'PK',

            //priorityList is shown at the beginning of list

            sortComparator: sortedByIsoCode
                ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                : null,
            onValuePicked: (Country country) {
              print("${country.name}");
              phoneCode = country.phoneCode;
              print(phoneCode);
            },
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: (value){
              if(value.isEmpty){
                return 'رقم الواتس اب مطلوب';
              }
              else{
                return null;
              }
            },
            controller: _phone,
            decoration: InputDecoration(
                hintText: 'XXX XXXX XXX',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
          ],
        ),
      );

  Widget _buildDropdownItemWithLongText(
          Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Expanded(child: Text("${country.name}")),
            ],
          ),
        ),
      );

  Widget _buildDropdownSelectedItemBuilder(
          Country country, double dropdownItemWidth) =>
      SizedBox(
          width: dropdownItemWidth,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(country),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(
                    '${country.name}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
                ],
              )));
}
