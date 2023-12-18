import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/presentation/provider/bottom_navigation_provider.dart';
import 'package:food_app/presentation/view/splash/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  AppModules().setup(); // Inyección de dependencias - guardadas en inject
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ],
      child: const MaterialApp(home: SplashPage()),
    );
  }
}
