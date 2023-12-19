import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard(
      {super.key, required this.ingredient, required this.measure});

  final String ingredient;
  final String measure;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (ingredient.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 100,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://www.themealdb.com/images/ingredients/$ingredient-small.png",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (measure.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                measure,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
