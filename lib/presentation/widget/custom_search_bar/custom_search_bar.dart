import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key, required this.searchController, required this.function});

  final TextEditingController searchController;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: searchController,
          onChanged: (text) {
            function.call(text);
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: 'Search Meals',
            hintText: 'Search meals by name...',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
