import 'package:flutter/material.dart';

class HidePasswordItem extends StatefulWidget {
  @override
  _HidePasswordItemState createState() => _HidePasswordItemState();
}

class _HidePasswordItemState extends State<HidePasswordItem> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 10,
      color: Color(0xff8D8D8D),
    );
  }
}
