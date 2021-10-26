import 'package:flutter/cupertino.dart';

class UserModel {
  final String email;
  final String fullName;
  final String password;
  final String phone;
  final String profile;
  final String uId;
  UserModel({
    @required this.email,
    @required this.fullName,
    @required this.password,
    @required this.phone,
    @required this.profile,
    @required this.uId
  });
}
