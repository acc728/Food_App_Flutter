import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/widget/ingredients_scroll_view/ingredient_card.dart';

class IngredientsScrollView extends StatelessWidget {
  const IngredientsScrollView({super.key, this.meal});

  final Meal? meal;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (meal?.strIngredient1 != null &&
                    meal!.strIngredient1!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient1 ?? "",
                      measure: meal?.strMeasure1 ?? ""),
                if (meal?.strIngredient2 != null &&
                    meal!.strIngredient2!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient2 ?? "",
                      measure: meal?.strMeasure2 ?? ""),
                if (meal?.strIngredient3 != null &&
                    meal!.strIngredient3!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient3 ?? "",
                      measure: meal?.strMeasure3 ?? ""),
                if (meal?.strIngredient4 != null &&
                    meal!.strIngredient4!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient4 ?? "",
                      measure: meal?.strMeasure4 ?? ""),
                if (meal?.strIngredient5 != null &&
                    meal!.strIngredient5!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient5 ?? "",
                      measure: meal?.strMeasure5 ?? ""),
                if (meal?.strIngredient6 != null &&
                    meal!.strIngredient6!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient6 ?? "",
                      measure: meal?.strMeasure6 ?? ""),
                if (meal?.strIngredient7 != null &&
                    meal!.strIngredient7!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient7 ?? "",
                      measure: meal?.strMeasure7 ?? ""),
                if (meal?.strIngredient8 != null &&
                    meal!.strIngredient8!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient8 ?? "",
                      measure: meal?.strMeasure8 ?? ""),
                if (meal?.strIngredient9 != null &&
                    meal!.strIngredient9!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient9 ?? "",
                      measure: meal?.strMeasure9 ?? ""),
                if (meal?.strIngredient10 != null &&
                    meal!.strIngredient10!.isNotEmpty)
                  IngredientCard(
                      ingredient: meal?.strIngredient10 ?? "",
                      measure: meal?.strMeasure10 ?? ""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
