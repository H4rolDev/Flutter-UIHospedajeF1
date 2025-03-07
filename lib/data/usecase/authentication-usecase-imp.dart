import 'package:flutter_hospedajef1/data/source/auth-api.dart';
import 'package:flutter_hospedajef1/data/source/localstorage/auth-storage.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-response.dart';
import 'package:flutter_hospedajef1/domain/auth/models/user-profile.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/domain/auth/usecase/authentication-useacase-main.dart';

class AuthenticationUsecaseImpl implements AuthenticationUsecase {
  final AuthApi _auth = AuthApi();
  final AuthStorage _storage = AuthStorage();

  @override
  Future<UserProfile?> isLogin() async {
    String? tokenLocal = await _storage.getToken();
    UserProfile? profile = await _storage.getProfile();
    return profile;
  }

  @override
  Future<UserProfile> login(LoginRequest body) async {
    LoginResponse res = await _auth.login(body);
    await _storage.saveToken(res.token);
    await _storage.saveProfile(res.profile);
    return res.profile;
  }

  @override
  Future<void> logout() {
    return _storage.clearAll();
  }

}
