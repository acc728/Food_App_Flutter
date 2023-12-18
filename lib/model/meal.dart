import 'dart:convert';

MealsResponse mealsResponseFromMap(String str) =>
    MealsResponse.fromMap(json.decode(str));

String mealsResponseToMap(MealsResponse data) => json.encode(data.toMap());

class MealsResponse {
  List<Meal> meals;

  MealsResponse({
    required this.meals,
  });

  factory MealsResponse.fromMap(Map<String, dynamic> json) => MealsResponse(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toMap())),
      };
}

class Meal {
  String idMeal;
  String strMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String strMealThumb;
  String? strTags;
  String? strYoutube;
  String? strIngredient1;
  String? strIngredient2;
  String? strIngredient3;
  String? strIngredient4;
  String? strIngredient5;
  String? strMeasure1;
  String? strMeasure2;
  String? strMeasure3;
  String? strMeasure4;
  String? strMeasure5;

  Meal(
      {required this.idMeal,
      required this.strMeal,
      required this.strCategory,
      required this.strArea,
      required this.strInstructions,
      required this.strMealThumb,
      required this.strTags,
      required this.strYoutube,
      required this.strIngredient1,
      required this.strIngredient2,
      required this.strIngredient3,
      required this.strIngredient4,
      required this.strIngredient5,
      required this.strMeasure1,
      required this.strMeasure2,
      required this.strMeasure3,
      required this.strMeasure4,
      required this.strMeasure5});

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
      idMeal: json["idMeal"],
      strMeal: json["strMeal"],
      strCategory: json["strCategory"],
      strArea: json["strArea"],
      strInstructions: json["strInstructions"],
      strMealThumb: json["strMealThumb"],
      strTags: json["strTags"],
      strYoutube: json["strYoutube"],
      strIngredient1: json["strIngredient1"],
      strIngredient2: json["strIngredient2"],
      strIngredient3: json["strIngredient3"],
      strIngredient4: json["strIngredient4"],
      strIngredient5: json["strIngredient5"],
      strMeasure1: json["strMeasure1"],
      strMeasure2: json["strMeasure2"],
      strMeasure3: json["strMeasure3"],
      strMeasure4: json["strMeasure4"],
      strMeasure5: json["strMeasure5"]);

  Map<String, dynamic> toMap() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strIngredient1": strIngredient1,
        "strIngredient2": strIngredient2,
        "strIngredient3": strIngredient3,
        "strIngredient4": strIngredient4,
        "strIngredient5": strIngredient5,
        "strMeasure1": strMeasure1,
        "strMeasure2": strMeasure2,
        "strMeasure3": strMeasure3,
        "strMeasure4": strMeasure4,
        "strMeasure5": strMeasure5
      };
}
