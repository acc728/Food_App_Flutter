import 'package:flutter/material.dart';
import 'package:food_app/presentation/widget/navigation/custom_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: CustomBottomNavigationBar(
          key: widget.key,
          navigationShell: widget.navigationShell,
        ),
      ),
    );
  }
}
