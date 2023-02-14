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