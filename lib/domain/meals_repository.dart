import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';

abstract class MealRepository {
  Future<Meal> getRandomMeal();
  Future<List<Meal>> getMealsByName(String name); //query param s
  Future<Meal> getMealById(String id); //query param i
  Future<List<MealCategory>> getMealCategories();
  Future<List<Meal>> getMealsByCategory(String category); //query param c
}
