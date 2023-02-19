import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/config/env.dart';
import 'package:flutter_project/types/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class AuthService {
  final LocalStorage storage;
  AuthService({required this.storage});

  bool _isAuthenticated = false;
  String? _accessToken;
  User? _user;

  String? get accessToken => _accessToken;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  Future clearSession() async {
    _isAuthenticated = false;
    await _setUser(null);
    await _setAccessToken(null);
  }

  initializeAuthState() async {
    var restoredUser = await storage.getItem('user');
    var restoredToken = await storage.getItem('accessToken');

    if (restoredUser != null && restoredToken != null) {
      debugPrint('RESTORING USER SESSION - VALIDATING TOKEN');
      Map<String, dynamic> payload = Jwt.parseJwt(restoredToken);
      int expiracy = int.parse(payload['expiracy'] ?? '0');
      if ((expiracy < DateTime.now().millisecondsSinceEpoch / 1000)) {
        debugPrint('USER SESSION EXPIRED');
        return;
      }

      await _setUser(User.fromJson(jsonDecode(restoredUser)));
      await _setAccessToken(accessToken);
      _isAuthenticated = true;
      debugPrint('USER SESSION VALID - RESTORATION CONFIRMED');
    }
  }

  Future _setUser(User? user) async {
    _user = user;
    if (user != null) {
      await storage.setItem('user', user.toJSONEncodable());
    } else {
      await storage.deleteItem('user');
    }
  }

  Future _setAccessToken(String? accessToken) async {
    _accessToken = accessToken;
    if (accessToken != null) {
      await storage.setItem('accessToken', accessToken);
    } else {
      await storage.deleteItem('accessToken');
    }
  }

  Future<bool> authenticate(
      {required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse('$API_BASE_URL/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == 201) {
        _isAuthenticated = true;
        await _setUser(User.fromJson(jsonDecode(response.body)['account']));
        await _setAccessToken(jsonDecode(response.body)['accessToken']);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<bool> registerUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(Uri.parse('$API_BASE_URL/auth/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'password': password
          }));

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
