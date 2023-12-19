import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/widget/ingredients_scroll_view/ingredient_card.dart';

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

    return SingleChildScrollView(
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
    );
  }
}
