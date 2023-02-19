import 'dart:convert';
import 'package:flutter_project/config/env.dart';
import 'package:http/http.dart' as http;

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'The password field can\'t be empty';
  }
  if (value.length < 8) {
    return 'Your password must be at least 8 characters long';
  }
  if (!RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*()_+,-./:;<=>?@\[\]{}|~])')
      .hasMatch(value)) {
    return 'Your password needs to contain at least 1 number, 1 capital letter, and 1 special character';
  }
  return null;
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'The email field can\'t be empty';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please input a valid email address';
  }
  return null;
}

String? validateRequiredField(String fieldName, String value) {
  if (value.isEmpty) {
    return 'The $fieldName field can\'t be empty';
  }

  return null;
}

Future<String?> verifyEmailAvailability(String? email) async {
  String? validPattern = validateEmail(email!);

  if (validPattern!.isEmpty == false) return validPattern;

  final response =
      await http.post(Uri.parse('$API_BASE_URL/api/auth/check-email-available'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
          }));

  if (response.statusCode == 200) {
    return null;
  } else {
    return 'Email address already used';
  }
}
