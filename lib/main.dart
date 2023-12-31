import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';

void main() {
  AppModules().setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.greenAccent,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.green,
              selectionHandleColor: Color.fromARGB(255, 17, 87, 19))),
    );
  }
}
