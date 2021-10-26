import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Profile {
  final String email;
  final String fullName;
  final String password;
  final String phone;
  final String profile;
  final String uId;
  Profile({
    @required this.email,
    @required this.fullName,
    @required this.password,
    @required this.phone,
    @required this.profile,
    @required this.uId,
  });

  Profile copyWith({
    String email,
    String fullName,
    String password,
    String phone,
    String profile,
    String uId,
  }) {
    return Profile(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      profile: profile ?? this.profile,
      uId: uId ?? this.uId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'password': password,
      'phone': phone,
      'profile': profile,
      'uId': uId,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      email: map['email'],
      fullName: map['fullName'],
      password: map['password'],
      phone: map['phone'],
      profile: map['profile'],
      uId: map['uId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(email: $email, fullName: $fullName, password: $password, phone: $phone, profile: $profile, uId: $uId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Profile &&
      other.email == email &&
      other.fullName == fullName &&
      other.password == password &&
      other.phone == phone &&
      other.profile == profile &&
      other.uId == uId;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      fullName.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      profile.hashCode ^
      uId.hashCode;
  }
}
