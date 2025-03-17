import 'package:dio/dio.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-response.dart';

class AuthApi {
  final Dio _dio = Dio(BaseOptions(
        baseUrl: 'http://localhost:8080/api/v1/auth', 
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {"Content-Type": "application/json"},
  ));

  Future<LoginResponse> login(LoginRequest body) async {
  try {
    print("📡 Enviando solicitud a la API...");
    print("📌 URL: ${_dio.options.baseUrl}/signin");
    print("📌 Body: ${body.toJson()}");

    Response response = await _dio.post(
      '/signin',
      data: body.toJson(),
      options: Options(contentType: Headers.jsonContentType),
    );

    print("✅ Respuesta recibida: ${response.data}");

    if (response.data == null || response.data.isEmpty) {
      throw Exception("Error: La respuesta del servidor está vacía.");
    }

    if (response.statusCode == 200) {
      if (response.data is! Map<String, dynamic>) {
        throw Exception("Error: La respuesta no es un JSON válido.");
      }

      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("Error en el login: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    print("❌ Error en la solicitud: $e");
    if (e.response != null) {
      print("📌 Error del servidor: ${e.response?.data}");
      throw Exception("Error del servidor: ${e.response?.data}");
    } else {
      throw Exception("Error de conexión: ${e.message}");
    }
  }
}

}
