import 'package:driver/Providers/myProvider.dart';
import 'package:driver/Screens/createAccount.dart';
import 'package:driver/Screens/login.dart';
import 'package:driver/Screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FashionDriver());
}

toastMsg(msg, color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

loginToast(msg, color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

class FashionDriver extends StatefulWidget {
  @override
  _FashionDriverState createState() => _FashionDriverState();
}

class _FashionDriverState extends State<FashionDriver> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        ///
        /// call splash screen
        ///
        home: Login(),
      ),
    );
  }
}
