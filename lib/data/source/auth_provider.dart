import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/data/source/auth-api.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-response.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  LoginResponse? _user;
  Map<String, dynamic>? _employeeData;

  LoginResponse? get user => _user;
  Map<String, dynamic>? get employeeData => _employeeData;

  Future<void> login(String email, String password) async {
    _user = await _authApi.login(LoginRequest(email: email, password: password));

    if (_user != null) {
      _employeeData = await _authApi.getEmployeeData(_user!.id, _user!.token);
    }
    notifyListeners();
  }
}
