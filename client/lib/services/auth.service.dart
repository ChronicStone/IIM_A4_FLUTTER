import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/config/env.dart';
import 'package:flutter_project/types/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  bool _isAuthenticated = false;
  String? _accessToken;
  User? _user;

  String? get accessToken => _accessToken;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  Future<bool> authenticate(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$API_BASE_URL/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      _isAuthenticated = true;
      _user = User.fromJson(jsonDecode(response.body)['account']);
      _accessToken = jsonDecode(response.body)['accessToken'];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    final response =
        await http.post(Uri.parse('$API_BASE_URL/api/auth/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'firstName': firstName,
              'lastName': lastName,
              'email': email,
              'password': password
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
