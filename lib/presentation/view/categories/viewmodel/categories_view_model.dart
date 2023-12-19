import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';

typedef CategoriesState = ResourceState<List<MealCategory>>;
typedef MealsState = ResourceState<List<Meal>>;

class CategoriesViewModel {
  final MealRepository _mealsRepository;
  final StreamController<CategoriesState> getMealCategoriesState =
      StreamController();

  final StreamController<MealsState> getMealsByNameState = StreamController();

  CategoriesViewModel({required MealRepository mealsRepository})
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

  fetchMealsByName(String name) {
    getMealsByNameState.add(ResourceState.loading());

    _mealsRepository
        .getMealsByName(name)
        .then((meals) => getMealsByNameState.add(ResourceState.success(meals)))
        .catchError(
            (error) => getMealsByNameState.add(ResourceState.error(error)));
  }

  void dispose() {
    getMealCategoriesState.close();
    getMealsByNameState.close();
  }
}
