import 'package:food_app/data/remote/error/remote_error_mapper.dart';
import 'package:food_app/data/remote/network_client.dart';
import 'package:food_app/data/remote/network_constants.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';

class MealRemoteImpl {
  final NetworkClient _networkClient;

  MealRemoteImpl({required NetworkClient networkClient})
      : _networkClient = networkClient;

  Future<Meal> getMealById(String id) async {
    try {
      final response = await _networkClient.dio
          .get(NetworkConstants.MEAL_BY_ID_PATH, queryParameters: {"i": id});

      return MealsResponse.fromMap(response.data).meals![0];
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<List<Meal>> getMealsByName(String name) async {
    try {
      final response = await _networkClient.dio.get(
          NetworkConstants.MEAL_BY_NAME_PATH,
          queryParameters: {"s": name});
      final meals = MealsResponse.fromMap(response.data).meals;
      return meals ?? [];
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<List<MealCategory>> getMealCategories() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.MEAL_CATEGORIES_PATH);
      return CategoriesResponse.fromMap(response.data).categories;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final response = await _networkClient.dio.get(
          NetworkConstants.MEAL_LIST_BY_CATEGORY_PATH,
          queryParameters: {"c": category});
      return MealsResponse.fromMap(response.data).meals!;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Meal> getRandomMeal() async {
    try {
      final response =
          await _networkClient.dio.get(NetworkConstants.RANDOM_MEAL_PATH);
      return MealsResponse.fromMap(response.data).meals![0];
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
