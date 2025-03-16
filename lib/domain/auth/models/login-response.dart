import 'package:flutter_hospedajef1/domain/auth/models/user-profile.dart';

class LoginResponse {
  String token;
  String id;
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
      id: json['id'].toString(),  
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      profile: json['profile'] != null
          ? UserProfile.fromJson(json['profile'])
          : UserProfile(email: '', roles: []), 
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['roles'] = this.roles;
    data['profile'] = this.profile.toJson();
    return data;
  }
}
