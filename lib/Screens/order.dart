import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Screens/slider.dart';
import 'package:driver/Widgets/orderItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// order screen class
///
class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  String email, profileUrl, name, password, phone, id;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,

      ///
      /// drawer or slider
      ///
      endDrawer: DrawerSlider(),
      backgroundColor: Color(0xffEFF2F3),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: Color(0xffEF4A8E),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),

            ///
            /// search icon
            ///
            leading: Image.asset('assets/search_ic.png'),
            centerTitle: true,

            ///
            /// home logo
            ///
            title: Image.asset('assets/logo_home.png'),

            ///
            /// menu icon
            ///
            actions: [
              InkWell(
                  onTap: () {
                    _scaffold.currentState.openEndDrawer();
                  },
                  child: Image.asset('assets/menu_ic.png'))
            ],
            // ...
          )),

      ///
      /// body
      ///
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffEFF2F3),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                ///
                /// number of items
                ///
                itemCount: 7,
                itemBuilder: (context, index) {
                  ///
                  /// call OrderItems
                  ///
                  return OrderItems();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
