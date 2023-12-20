import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';

typedef CategoriesState = ResourceState<List<MealCategory>>;
typedef MealListState = ResourceState<List<Meal>>;
typedef MealState = ResourceState<Meal>;
typedef MealDetailState = ResourceState<Meal>;

class MealsViewModel {
  final MealRepository _mealsRepository;

  final StreamController<CategoriesState> getMealCategoriesState =
      StreamController();
  final StreamController<MealListState> getFavoriteMealListState =
      StreamController();
  final StreamController<MealDetailState> getMealState = StreamController();
  final StreamController<MealListState> getMealListByCategoryState =
      StreamController();
  final StreamController<MealState> getRandomRecipeState = StreamController();

  final StreamController<MealListState> getMealsByNameState =
      StreamController();

  final StreamController<ResourceState<bool>> getMealIsFavoriteState =
      StreamController();

  MealsViewModel({required MealRepository mealsRepository})
      : _mealsRepository = mealsRepository;

  fetchMealsCategories() {
    getMealCategoriesState.add(ResourceState.loading());

    _mealsRepository
        .getMealCategories()
        .then((categories) =>
            getMealCategoriesState.add(ResourceState.success(categories)))
        .catchError(
            (error) => getMealCategoriesState.add(ResourceState.error(error)));
  }

  fetchFavoriteMealList() {
    getFavoriteMealListState.add(ResourceState.loading());

    _mealsRepository
        .getFavoriteMeals()
        .then((mealList) =>
            getFavoriteMealListState.add(ResourceState.success(mealList)))
        .catchError((error) =>
            getFavoriteMealListState.add(ResourceState.error(error)));
  }

  fetchMealListByCategory(String category) {
    getMealListByCategoryState.add(ResourceState.loading());

    _mealsRepository
        .getMealsByCategory(category)
        .then((mealList) =>
            getMealListByCategoryState.add(ResourceState.success(mealList)))
        .catchError((error) =>
            getMealListByCategoryState.add(ResourceState.error(error)));
  }

  fetchRandomRecipe() {
    getRandomRecipeState.add(ResourceState.loading());

    _mealsRepository
        .getRandomMeal()
        .then((meal) => getRandomRecipeState.add(ResourceState.success(meal)))
        .catchError(
            (error) => getRandomRecipeState.add(ResourceState.error(error)));
  }

  fetchMealsByName(String name) {
    getMealsByNameState.add(ResourceState.loading());

    _mealsRepository
        .getMealsByName(name)
        .then((meals) => getMealsByNameState.add(ResourceState.success(meals)))
        .catchError(
            (error) => getMealsByNameState.add(ResourceState.error(error)));
  }

  deleteFavoriteMeal(Meal meal) {
    _mealsRepository.deleteFavoriteMeal(meal);
    getMealIsFavoriteState.add(ResourceState.success(false));

    fetchFavoriteMealList();
  }

  fetchMealDetails(String id) {
    getMealState.add(ResourceState.loading());

    _mealsRepository
        .getMealById(id)
        .then((meal) => getMealState.add(ResourceState.success(meal)))
        .catchError((error) => getMealState.add(ResourceState.error(error)));
  }

  isFavoriteMeal(Meal meal) {
    _mealsRepository
        .isFavoriteMeal(meal)
        .then((favorite) =>
            getMealIsFavoriteState.add(ResourceState.success(favorite)))
        .catchError(
            (error) => getMealIsFavoriteState.add(ResourceState.error(error)));
  }

  addFavoriteMeal(Meal meal) {
    _mealsRepository.addFavoriteMeal(meal);

    getMealIsFavoriteState.add(ResourceState.success(true));

    fetchFavoriteMealList();
  }

  void dispose() {
    getMealCategoriesState.close();
    getFavoriteMealListState.close();
    getMealState.close();
    getMealListByCategoryState.close();
    getRandomRecipeState.close();
    getMealIsFavoriteState.close();
  }
}
