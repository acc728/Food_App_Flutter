import 'dart:async';

import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';

typedef MealListState = ResourceState<Meal>;

class RandomRecipeViewModel {
  final MealRepository _mealsRepository;
  final StreamController<MealListState> getRandomRecipeState =
      StreamController();

  RandomRecipeViewModel({required MealRepository mealsRepository})
      : _mealsRepository = mealsRepository;

  fetchRandomRecipe() {
    getRandomRecipeState.add(ResourceState.loading());

    _mealsRepository
        .getRandomMeal()
        .then((meal) => getRandomRecipeState.add(ResourceState.success(meal)))
        .catchError(
            (error) => getRandomRecipeState.add(ResourceState.error(error)));
  }

  void dispose() {
    getRandomRecipeState.close();
  }
}
