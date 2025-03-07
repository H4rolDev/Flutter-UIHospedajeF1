import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_navigator.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospedaje Formula 1',
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}