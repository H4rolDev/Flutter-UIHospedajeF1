import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/domain/auth/models/user-profile.dart';

abstract class AuthenticationUsecase {
  Future<UserProfile> login(LoginRequest body);
  Future<void> logout();
  Future<UserProfile?> isLogin();
}
