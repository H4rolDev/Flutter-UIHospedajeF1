import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/firebase/fcm.dart';
import 'package:flutter_hospedajef1/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hospedajef1/data/source/auth_provider.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_navigator.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_routes.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key}){
    fcmAdapter.initialize().then(
      (settings) => fcmAdapter.startGetMessages()
    );
  }
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

void fetchData() async {
  final response = await http.get(
    Uri.parse("http://localhost:8080/api/v1/*"),
    headers: {"Origin": "*"},
  );

  if (response.statusCode == 200) {
    print("Respuesta: ${response.body}");
  } else {
    print("Error: ${response.statusCode}");
  }
}
