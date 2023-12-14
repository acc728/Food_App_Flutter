import 'package:food_app/model/category.dart';
import 'package:food_app/model/meal.dart';

abstract class MealRepository {
  Future<Meal> getRandomMeal();
  Future<Meal> getMealByName(String name); //query param s
  Future<Meal> getMealById(int id); //query param i
  Future<List<MealCategory>> getMealCategories();
  Future<List<Meal>> getMealsByCategory(String category); //query param c
}