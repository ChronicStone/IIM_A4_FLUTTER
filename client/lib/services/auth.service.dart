import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/config/env.dart';
import 'package:flutter_project/types/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences _prefs;
  AuthService(this._prefs);

  bool get isAuthenticated => _prefs.getBool('isAuthenticated') ?? false;
  String? get accessToken => _prefs.getString('accessToken');
  User? get user => _getUserFromPrefs();

  void _saveUserToPrefs(User? user) {
    if (user != null) {
      _prefs.setString('user', jsonEncode(user.toJson()));
    } else {
      _prefs.remove('user');
    }
  }

  User? _getUserFromPrefs() {
    final userJson = _prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  void clearSession() {
    _prefs.remove('isAuthenticated');
    _prefs.remove('accessToken');
    _saveUserToPrefs(null);
  }

  Future<bool> authenticate({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      _prefs.setBool('isAuthenticated', true);
      _saveUserToPrefs(User.fromJson(jsonDecode(response.body)['account']));
      _prefs.setString('accessToken', jsonDecode(response.body)['accessToken']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$API_BASE_URL/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }
}
