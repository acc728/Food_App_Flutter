import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';

class FavoriteMealListProvider extends ChangeNotifier {
  List<Meal> _favoriteMealsList = [];

  List<Meal> get favoriteMealsList => _favoriteMealsList;

  void updateFavoriteList(List<Meal> newFavoriteMealList) {
    _favoriteMealsList = newFavoriteMealList;
    notifyListeners();
  }

  void updateItemAdded(Meal meal) {
    _favoriteMealsList.add(meal);
    notifyListeners();
  }

  void updateItemDeleted(Meal meal) {
    _favoriteMealsList.removeWhere((element) => element.idMeal == meal.idMeal);
    notifyListeners();
  }
}
