import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';

abstract class MealRepository {
  Future<Meal> getRandomMeal();
  Future<List<Meal>> getMealsByName(String name);
  Future<Meal> getMealById(String id);
  Future<List<MealCategory>> getMealCategories();
  Future<List<Meal>> getMealsByCategory(String category);
  Future<List<Meal>> getFavoriteMeals();
  addFavoriteMeal(Meal meal);
  deleteFavoriteMeal(Meal meal);
  Future<bool> isFavoriteMeal(Meal meal);
}
