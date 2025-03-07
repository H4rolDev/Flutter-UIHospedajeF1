import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/presentation/screens/habitaciones.dart';
import 'package:flutter_hospedajef1/presentation/screens/home.dart';
import 'package:flutter_hospedajef1/presentation/screens/login.dart';
import 'package:flutter_hospedajef1/presentation/screens/descripcionHabitacion.dart';
import 'app_routes.dart';


class AppNavigator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => Login());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => Home());

      case AppRoutes.habitaciones:
        return MaterialPageRoute(builder: (_) => Habitaciones());

      case AppRoutes.descripcionHabitacion:
        return MaterialPageRoute(builder: (_) => DescripcionHabitacion());

      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}
