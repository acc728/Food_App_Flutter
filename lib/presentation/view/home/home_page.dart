import 'package:flutter/material.dart';
import 'package:food_app/presentation/provider/bottom_navigation_provider.dart';
import 'package:food_app/presentation/view/categories/categories_page.dart';
import 'package:food_app/presentation/view/random_recipe/random_recipe_page.dart';
import 'package:food_app/presentation/widget/bottom_navigation/custom_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [const CategoriesPage(), const RandomRecipePage()];

  @override
  Widget build(BuildContext context) {
    BottomNavigationProvider bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Foodies")),
      body: IndexedStack(
        index: bottomNavigationProvider.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(key: widget.key),
    );
  }
}
