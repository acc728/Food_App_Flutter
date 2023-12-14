import 'package:flutter/material.dart';
import 'package:food_app/presentation/view/categories/categories_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final screens = [const CategoriesPage(), const Text("data")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Foodies")),
      body: SafeArea(
          child: IndexedStack(
        index: selectedIndex,
        children: screens,
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
        ],
      ),
    );
  }
}
