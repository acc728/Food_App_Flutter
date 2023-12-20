import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      required this.searchController,
      required this.onChangedFunction});

  final TextEditingController searchController;
  final Function(String) onChangedFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: searchController,
          onChanged: (text) {
            onChangedFunction.call(text);
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: 'Search Meals',
            hintText: 'Introduce the food name...',
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
