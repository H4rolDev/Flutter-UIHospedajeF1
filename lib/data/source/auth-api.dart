import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-response.dart';
import 'package:dio/dio.dart';

class AuthApi {
  Future<LoginResponse> login(LoginRequest body) async {
    final dio = Dio();

    try {
      // Asegúrate de usar el endpoint correcto
      Response response = await dio.post(
        'http://http://localhost:8080/api/auth/signin',  // Cambia a tu URL real de la API
        data: body.toJson(),  // Asegúrate de que la solicitud sea JSON
        options: Options(contentType: "application/json"),
      );

      if (response.statusCode == 200) {
        // Procesar la respuesta
        return LoginResponse.fromJson(response.data);
      } else {
        // Manejar errores de servidor
        throw Exception("No se logeo correctamente");
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      throw Exception("Error en la conexión con la API");
    }
  }

}
