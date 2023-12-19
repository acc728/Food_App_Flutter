import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';

typedef MealDetailState = ResourceState<Meal>;

class MealDetailViewModel {
  final MealRepository _mealsRepository;
  final StreamController<MealDetailState> getMealState = StreamController();

  MealDetailViewModel({required MealRepository mealsRepository})
      : _mealsRepository = mealsRepository;

  fetchMealDetails(String id) {
    getMealState.add(ResourceState.loading());

    _mealsRepository
        .getMealById(id)
        .then((meal) => getMealState.add(ResourceState.success(meal)))
        .catchError((error) => getMealState.add(ResourceState.error(error)));
  }

  void dispose() {
    getMealState.close();
  }
}
