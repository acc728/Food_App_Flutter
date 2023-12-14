import 'package:flutter/material.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/animation_foodies.json',
            repeat: true, animate: true),
      ),
    );
  }

  _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      context.go(NavigationRoutes.MEAL_CATEGORIES_ROUTE);
    }
  }
}
