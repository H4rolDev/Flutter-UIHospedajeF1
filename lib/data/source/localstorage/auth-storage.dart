import 'package:flutter_hospedajef1/domain/auth/models/user-profile.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class AuthStorage {
  // Inicializa localStorage correctamente
  final LocalStorage localStorage = LocalStorage('my_data_storage');

  Future<void> clearAll() {
    localStorage.clear();
    return Future.value();
  }

  Future<void> saveToken(String token) {
    localStorage.setItem('jwt', token);
    return Future.value();
  }

  Future<String?> getToken() {
    String? token = localStorage.getItem('jwt');
    return Future.value(token);
  }

  Future<void> saveProfile(UserProfile profile) {
    Map<String, dynamic> map = profile.toJson();
    String profileJson = json.encode(map);

    localStorage.setItem('profile', profileJson);
    return Future.value();
  }

  Future<UserProfile?> getProfile() {
    String? profileJson = localStorage.getItem('profile');
    if (profileJson == null) return Future.value(null);

    Map<String, dynamic> data = json.decode(profileJson);
    UserProfile profile = UserProfile.fromJson(data);

    return Future.value(profile);
  }
}
