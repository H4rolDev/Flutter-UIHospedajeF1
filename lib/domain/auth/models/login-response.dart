import 'package:flutter_hospedajef1/domain/auth/models/user-profile.dart';

class LoginResponse {
  String token;
  int id;  // Cambiar de String a int
  String email;
  List<String> roles;
  UserProfile profile;

  LoginResponse({
    required this.token,
    required this.id,
    required this.email,
    required this.roles,
    required this.profile,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '', 
      id: int.tryParse(json['id'].toString()) ?? 0,  // Convertir id a int
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      profile: json['profile'] != null
          ? UserProfile.fromJson(json['profile'])
          : UserProfile(email: '', roles: []), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,  // Ya es un entero
      'email': email,
      'roles': roles,
      'profile': profile.toJson(),
    };
  }
}
