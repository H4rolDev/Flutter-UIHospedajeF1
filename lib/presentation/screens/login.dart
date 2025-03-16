// screens/login.dart
import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/data/usecase/authentication-usecase-imp.dart';
import 'package:flutter_hospedajef1/domain/auth/models/login-request.dart';
import 'package:flutter_hospedajef1/core/colors.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_routes.dart';
import 'package:validators/validators.dart'; // Librería para validaciones

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Clave para manejar el formulario

  // Método para validar email
  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'El email es obligatorio';
    } else if (!isEmail(value)) {
      return 'Formato de email no válido';
    }
    return null;
  }

  // Método para validar contraseña
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña es obligatoria';
    } else if (value.length < 5) {
      return 'Debe tener al menos 4 caracteres';
    } 
    return null;
  }

  void login(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    AuthenticationUsecaseImpl _auth = AuthenticationUsecaseImpl();
    LoginRequest reqData = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    _auth.login(reqData).then((profile) {
      print("${profile.email} -- ${profile.roles.join(', ')}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("¡Login exitoso!")),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Credenciales incorrectas. Inténtalo de nuevo")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.loginBg,
        ),
        child: SafeArea(
          child: Form(
            key: _formKey, // Asigna la clave al formulario
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 650,
                  child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0, bottom: 8.0),
                    child: Text(
                      'Usuario',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su usuario',
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) => _validateEmail(value!),
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0, bottom: 8.0),
                    child: Text(
                      'Contraseña',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su contraseña',
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) => _validatePassword(value!),
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => login(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Color(0xff7B6428),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: SizedBox(
                      width: 550,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  '@ Hospedaje Formula 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff9A9A9A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
