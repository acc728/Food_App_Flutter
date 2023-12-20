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
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: widget.navigationShell,
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 75,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(115, 255, 255, 255),
                    Colors.white
                  ],
                      stops: [
                    0,
                    0.5
                  ])),
            ),
            CustomBottomNavigationBar(
              key: widget.key,
              navigationShell: widget.navigationShell,
            ),
          ],
        ),
      ),
    );
  }
}
