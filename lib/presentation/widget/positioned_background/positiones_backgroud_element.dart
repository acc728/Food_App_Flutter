import 'package:flutter/material.dart';

class PositionedBackgroundElement extends StatelessWidget {
  const PositionedBackgroundElement(
      {super.key, required this.color1, required this.color2});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: -250,
        left: -200,
        right: -200,
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color1,
                color2,
              ],
            ),
          ),
        ));
  }
}
