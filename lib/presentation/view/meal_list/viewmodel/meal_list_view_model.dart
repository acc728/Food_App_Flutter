import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';

typedef MealListState = ResourceState<List<Meal>>;

class MealListViewModel {
  final MealRepository _mealsRepository;
  final StreamController<MealListState> getMealListByCategoryState =
      StreamController();

  MealListViewModel({required MealRepository mealsRepository})
      : _mealsRepository = mealsRepository;

  fetchMealListByCategory(String category) {
    getMealListByCategoryState.add(ResourceState.loading());

    _mealsRepository
        .getMealsByCategory(category)
        .then((mealList) =>
            getMealListByCategoryState.add(ResourceState.success(mealList)))
        .catchError((error) =>
            getMealListByCategoryState.add(ResourceState.error(error)));
  }

  void dispose() {
    getMealListByCategoryState.close();
  }
}
