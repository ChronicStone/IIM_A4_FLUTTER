import 'dart:convert';
import 'package:flutter_project/config/env.dart';
import 'package:http/http.dart' as http;

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Veuillez saisir un mot de passe';
  }
  if (value.length < 8) {
    return 'Votre mot de passe doit faire au moins 8 caractères de long';
  }
  if (!RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*()_+,-./:;<=>?@\[\]{}|~])')
      .hasMatch(value)) {
    return 'Votre mot de passe doit contenir au moins un chiffre, une lettre majuscule et un caractère spécial';
  }
  return null;
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Le champ adresse email est requis';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Veuillez saisir une adresse email valide';
  }
  return null;
}

String? validateRequiredField(String fieldName, String value) {
  if(value.isEmpty) {
    return 'Le champ $fieldName doit être rempli';
  }

  return null;
}

Future<String?> verifyEmailAvailability(String? email) async {
    String? validPattern = validateEmail(email!);

    if(validPattern!.isEmpty == false) return validPattern;

    final response = await http.post(
      Uri.parse('$API_BASE_URL/api/auth/check-email-available'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      })
    );

    if(response.statusCode == 200) {
      return null;
    } else {
      return 'Adresse email déjà utilisée';
    }
  }