import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';

class FavoriteMealProvider extends ChangeNotifier {
  List<Meal> _favoriteMealsList = [];
  bool _isFavoriteMeal = false;

  List<Meal> get favoriteMealsList => _favoriteMealsList;
  bool get isFavoriteMeal => _isFavoriteMeal;

  void updateFavoriteList(List<Meal> newFavoriteMealList) {
    _favoriteMealsList = newFavoriteMealList;
    notifyListeners();
  }

  void updateMealAddedToFavorites(Meal meal) {
    _favoriteMealsList.add(meal);
    notifyListeners();
  }

  void updateMealDeletedToFavorites(Meal meal) {
    _favoriteMealsList.removeWhere((element) => element.idMeal == meal.idMeal);
    notifyListeners();
  }

  void updateIsFavoriteMeal(bool isFavorite) {
    _isFavoriteMeal = isFavorite;
    notifyListeners();
  }
}
