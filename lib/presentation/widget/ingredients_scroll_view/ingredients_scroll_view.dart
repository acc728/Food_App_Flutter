import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/widget/ingredients_scroll_view/ingredient_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IngredientsScrollView extends StatelessWidget {
  const IngredientsScrollView({super.key, this.meal});

  final Meal? meal;

  @override
  Widget build(BuildContext context) {
    final List<Widget> ingredientCards = [];

    for (int i = 1; i <= 20; i++) {
      final String? ingredient = meal?['strIngredient$i'];
      final String? measure = meal?['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientCards.add(
          IngredientCard(
            ingredient: ingredient,
            measure: measure != null
                ? measure.isEmpty
                    ? 'Taste'
                    : measure
                : '',
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.cookie_outlined),
                  SizedBox(width: 8),
                  Text(
                    "Ingredients",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              if (meal != null && meal!.strSource != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        launchUrlString(meal!.strSource!);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black),
                      child: const Row(
                        children: [
                          Icon(Icons.notes),
                          SizedBox(width: 2),
                          Text("Web")
                        ],
                      )),
                ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: ingredientCards,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
