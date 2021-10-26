import 'package:driver/Screens/login.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  ///
  /// delay 5 second 
  /// 
  void initState(){
    Future.delayed(Duration(seconds: 5), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      /// main body
      /// 
      body: Container(
        ////
        /// full screen
        /// 
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        ///
        /// background image
        /// 
        child: Image.asset('assets/login_logo.png')
      ),
    );
  }
}