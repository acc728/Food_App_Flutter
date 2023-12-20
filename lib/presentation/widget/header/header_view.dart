import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 10),
          child: Text(title,
              style: GoogleFonts.pacifico(
                  fontSize: 26.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 10, top: 4),
          child: Text(message,
              style: const TextStyle(fontSize: 16.0, color: Colors.black)),
        ),
      ],
    );
  }
}
