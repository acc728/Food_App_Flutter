import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.meal});

  final Meal? meal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 70),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.only(bottom: 10, top: 0, left: 15, right: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            context.go(NavigationRoutes.RANDOM_MEAL_DETAIL_ROUTE,
                extra: meal?.idMeal);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              meal != null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: meal!.strMealThumb != null
                          ? CachedNetworkImage(
                              imageUrl: meal!.strMealThumb!,
                              fit: BoxFit.cover,
                              height: 240,
                            )
                          : Image.asset(
                              'assets/images/food_placeholder.jpg',
                              fit: BoxFit.cover,
                              height: 240,
                            ),
                    )
                  : Image.asset(
                      'assets/images/food_placeholder.jpg',
                      height: 240,
                      fit: BoxFit.cover,
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal?.strMeal ?? "Meal name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 160,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              meal?.strInstructions ?? "Description not found",
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
