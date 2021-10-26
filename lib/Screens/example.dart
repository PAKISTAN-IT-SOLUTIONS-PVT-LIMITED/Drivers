import 'dart:ui';

import 'package:flutter/material.dart';

class Exampe extends StatefulWidget {
  @override
  _ExampeState createState() => _ExampeState();
}

class _ExampeState extends State<Exampe> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Required';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      print('OK');
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
