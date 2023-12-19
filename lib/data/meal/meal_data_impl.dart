import 'package:food_app/data/meal/remote/meal_remote_impl.dart';
import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';

class MealDataImpl extends MealRepository {
  final MealRemoteImpl _remoteImpl;

  MealDataImpl({required MealRemoteImpl remoteImpl}) : _remoteImpl = remoteImpl;

  @override
  Future<Meal> getMealById(String id) {
    return _remoteImpl.getMealById(id);
  }

  @override
  Future<List<Meal>> getMealsByName(String name) {
    return _remoteImpl.getMealsByName(name);
  }

  @override
  Future<List<MealCategory>> getMealCategories() {
    return _remoteImpl.getMealCategories();
  }

  @override
  Future<List<Meal>> getMealsByCategory(String category) {
    return _remoteImpl.getMealsByCategory(category);
  }

  @override
  Future<Meal> getRandomMeal() {
    return _remoteImpl.getRandomMeal();
  }
}
