import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppUserModel {
  final String? id;
  final String fullName;
  final String userName;
  final String email;
  final String? password;
  final String? phoneNumber;
  final String? token;
  final String? privateRole;
  final bool? active;
  final Uint8List? avatar;


  AppUserModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    this.password,
    this.phoneNumber,
    this.token,
    this.privateRole,
    this.active,
    this.avatar
  });

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'],
      fullName: map['name'] ?? map['fullName'] ?? '',
      userName: map['username'] ?? map['userName'] ?? '',
      email: map['email'] ?? '',
      password: map['passwordHash'],
      phoneNumber: map['phoneNumber'],
      token: map['token'],
      privateRole: map['privateRole'],
      active: map['actve'],
      avatar: map['avatar'] != null && map['avatar'] is String ? base64Decode(map['avatar']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'username': userName,
      'email': email,
      'passwordHash': password,
      'phoneNumber': phoneNumber,
      'token': token,
      'privateRole': privateRole,
      'active': active,
      'avatar': avatar !=null ? base64Encode(avatar!) : null,
    };
  }
}