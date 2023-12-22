import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, required this.category});

  final MealCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          context.go(NavigationRoutes.MEAL_LIST_ROUTE,
              extra: category.strCategory);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 190,
                child: CachedNetworkImage(
                  imageUrl: category.strCategoryThumb,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  category.strCategory,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
