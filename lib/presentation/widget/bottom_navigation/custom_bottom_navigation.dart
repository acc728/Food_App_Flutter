import 'package:flutter/material.dart';
import 'package:food_app/presentation/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationProvider bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.deepPurpleAccent,
      currentIndex: bottomNavigationProvider.currentIndex,
      onTap: (newIndex) {
        setState(() {
          bottomNavigationProvider.updateIndex(newIndex);
        });
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.food_bank), label: "Random Recipe"),
      ],
    );
  }
}
