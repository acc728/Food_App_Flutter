import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';

typedef CategoriesState = ResourceState<List<MealCategory>>;

class HomeViewModel {
  final MealRepository _mealsRepository;
  final StreamController<CategoriesState> getMealCategoriesState =
      StreamController();

  HomeViewModel({required MealRepository mealsRepository})
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

  void dispose() {
    getMealCategoriesState.close();
  }
}
