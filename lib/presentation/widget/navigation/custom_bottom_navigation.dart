import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 75,
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: (value) {
        widget.navigationShell.goBranch(value,
            initialLocation: value == widget.navigationShell.currentIndex);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.fastfood_outlined),
          selectedIcon: Icon(Icons.fastfood),
          label: "Categories",
        ),
        NavigationDestination(
          icon: Icon(Icons.food_bank_outlined),
          selectedIcon: Icon(Icons.food_bank),
          label: "Random Meal",
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_outline),
          selectedIcon: Icon(Icons.favorite),
          label: "Favorites",
        ),
      ],
    );
  }
}
