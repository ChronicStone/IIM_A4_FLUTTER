abstract class Usert {
  late String id;
  late String firstName;
  late String lastName;
  late String email;
}

abstract class AuthPayload {
  late User user;
  late String accessToken;
}

abstract class RegisterUserResponse {
  late bool success;
  late String? message;
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  const User({required this.id, required this.firstName, required this.lastName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}