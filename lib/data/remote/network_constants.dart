class NetworkConstants {
  static const BASE_URL = "www.themealdb.com/api/json/v1/1";

  static const MEAL_BY_NAME_PATH = "$BASE_URL/search.php"; //query parameter "s"
  static const MEAL_BY_ID_PATH = "$BASE_URL/lookup.php"; //query parameter "i"
  static const RANDOM_MEAL_PATH = "$BASE_URL/random.php";
  static const MEAL_CATEGORIES_PATH = "$BASE_URL/categories.php";
  //query parameter "c"
  static const MEAL_LIST_BY_CATEGORY_PATH = "$BASE_URL/filter.php";
}
