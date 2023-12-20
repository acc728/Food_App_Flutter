import 'package:food_app/model/meal.dart';
import 'package:sqflite/sqflite.dart';

class MealLocalImpl {
  static const String mealsTable = "meals";
  Database? _db;

  Future<List<Meal>> getFavoriteMeals() async {
    Database db = await _getDb();

    final meals = await db.query(MealLocalImpl.mealsTable);
    final favoriteMealList = meals.map((e) => Meal.fromMap(e));

    await _closeDb();

    return favoriteMealList.toList();
  }

  addFavoriteMeal(Meal meal) async {
    Database db = await _getDb();

    await db.insert(MealLocalImpl.mealsTable, meal.toMap());

    await _closeDb();
  }

  deleteFavoriteMeal(Meal meal) async {
    Database db = await _getDb();

    await db.delete(
      MealLocalImpl.mealsTable,
      where: 'idMeal = ?',
      whereArgs: [meal.idMeal],
    );

    await _closeDb();
  }

  Future<bool> isFavoriteMeal(Meal meal) async {
    Database db = await _getDb();

    final meals = await db.query(MealLocalImpl.mealsTable);
    final favoriteMealList = meals.map((e) => Meal.fromMap(e));

    await _closeDb();

    return favoriteMealList
        .any((favoriteMeal) => favoriteMeal.idMeal == meal.idMeal);
  }

  Future<Database> _getDb() async {
    if (_db == null || !_db!.isOpen) {
      _db = await openDatabase('favorite_meals.db', version: 1);
    }

    await _createTables(_db!);

    return _db!;
  }

  _closeDb() async {
    if (_db != null && _db!.isOpen) {
      await _db!.close();
    }
  }

  _createTables(Database db) async {
    db.execute(
        "CREATE TABLE IF NOT EXISTS $mealsTable (idMeal TEXT PRIMARY KEY, strMeal TEXT, strCategory TEXT, strArea TEXT, strInstructions TEXT, strMealThumb TEXT, strTags TEXT, strYoutube TEXT, strSource TEXT, strIngredient1 TEXT, strIngredient2 TEXT, strIngredient3 TEXT, strIngredient4 TEXT, strIngredient5 TEXT, strIngredient6 TEXT, strIngredient7 TEXT, strIngredient8 TEXT, strIngredient9 TEXT, strIngredient10 TEXT, strIngredient11 TEXT, strIngredient12 TEXT, strIngredient13 TEXT, strIngredient14 TEXT, strIngredient15 TEXT, strIngredient16 TEXT, strIngredient17 TEXT, strIngredient18 TEXT, strIngredient19 TEXT, strIngredient20 TEXT, strMeasure1 TEXT, strMeasure2 TEXT, strMeasure3 TEXT, strMeasure4 TEXT, strMeasure5 TEXT, strMeasure6 TEXT, strMeasure7 TEXT, strMeasure8 TEXT, strMeasure9 TEXT, strMeasure10 TEXT, strMeasure11 TEXT, strMeasure12 TEXT, strMeasure13 TEXT, strMeasure14 TEXT, strMeasure15 TEXT, strMeasure16 TEXT, strMeasure17 TEXT, strMeasure18 TEXT, strMeasure19 TEXT, strMeasure20 TEXT)");
  }
}
