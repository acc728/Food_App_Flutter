import 'dart:convert';

MealsResponse mealsResponseFromMap(String str) =>
    MealsResponse.fromMap(json.decode(str));

String mealsResponseToMap(MealsResponse data) => json.encode(data.toMap());

class MealsResponse {
  List<Meal>? meals;

  MealsResponse({
    required this.meals,
  });

  factory MealsResponse.fromMap(Map<String, dynamic> json) => MealsResponse(
        meals: json["meals"] == null
            ? []
            : List<Meal>.from(json["meals"]!.map((x) => Meal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "meals": meals == null
            ? []
            : List<dynamic>.from(meals!.map((x) => x.toMap())),
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
  String? strSource;
  String? strIngredient1;
  String? strIngredient2;
  String? strIngredient3;
  String? strIngredient4;
  String? strIngredient5;
  String? strIngredient6;
  String? strIngredient7;
  String? strIngredient8;
  String? strIngredient9;
  String? strIngredient10;
  String? strIngredient11;
  String? strIngredient12;
  String? strIngredient13;
  String? strIngredient14;
  String? strIngredient15;
  String? strIngredient16;
  String? strIngredient17;
  String? strIngredient18;
  String? strIngredient19;
  String? strIngredient20;
  String? strMeasure1;
  String? strMeasure2;
  String? strMeasure3;
  String? strMeasure4;
  String? strMeasure5;
  String? strMeasure6;
  String? strMeasure7;
  String? strMeasure8;
  String? strMeasure9;
  String? strMeasure10;
  String? strMeasure11;
  String? strMeasure12;
  String? strMeasure13;
  String? strMeasure14;
  String? strMeasure15;
  String? strMeasure16;
  String? strMeasure17;
  String? strMeasure18;
  String? strMeasure19;
  String? strMeasure20;

  Meal(
      {required this.idMeal,
      required this.strMeal,
      this.strCategory,
      this.strArea,
      this.strInstructions,
      required this.strMealThumb,
      this.strTags,
      this.strYoutube,
      this.strSource,
      this.strIngredient1,
      this.strIngredient2,
      this.strIngredient3,
      this.strIngredient4,
      this.strIngredient5,
      this.strIngredient6,
      this.strIngredient7,
      this.strIngredient8,
      this.strIngredient9,
      this.strIngredient10,
      this.strIngredient11,
      this.strIngredient12,
      this.strIngredient13,
      this.strIngredient14,
      this.strIngredient15,
      this.strIngredient16,
      this.strIngredient17,
      this.strIngredient18,
      this.strIngredient19,
      this.strIngredient20,
      this.strMeasure1,
      this.strMeasure2,
      this.strMeasure3,
      this.strMeasure4,
      this.strMeasure5,
      this.strMeasure6,
      this.strMeasure7,
      this.strMeasure8,
      this.strMeasure9,
      this.strMeasure10,
      this.strMeasure11,
      this.strMeasure12,
      this.strMeasure13,
      this.strMeasure14,
      this.strMeasure15,
      this.strMeasure16,
      this.strMeasure17,
      this.strMeasure18,
      this.strMeasure19,
      this.strMeasure20});

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
      idMeal: json["idMeal"],
      strMeal: json["strMeal"],
      strCategory: json["strCategory"],
      strArea: json["strArea"],
      strInstructions: json["strInstructions"],
      strMealThumb: json["strMealThumb"],
      strTags: json["strTags"],
      strYoutube: json["strYoutube"],
      strSource: json["strSource"],
      strIngredient1: json["strIngredient1"],
      strIngredient2: json["strIngredient2"],
      strIngredient3: json["strIngredient3"],
      strIngredient4: json["strIngredient4"],
      strIngredient5: json["strIngredient5"],
      strIngredient6: json["strIngredient6"],
      strIngredient7: json["strIngredient7"],
      strIngredient8: json["strIngredient8"],
      strIngredient9: json["strIngredient9"],
      strIngredient10: json["strIngredient10"],
      strIngredient11: json["strIngredient11"],
      strIngredient12: json["strIngredient12"],
      strIngredient13: json["strIngredient13"],
      strIngredient14: json["strIngredient14"],
      strIngredient15: json["strIngredient15"],
      strIngredient16: json["strIngredient16"],
      strIngredient17: json["strIngredient17"],
      strIngredient18: json["strIngredient18"],
      strIngredient19: json["strIngredient19"],
      strIngredient20: json["strIngredient20"],
      strMeasure1: json["strMeasure1"],
      strMeasure2: json["strMeasure2"],
      strMeasure3: json["strMeasure3"],
      strMeasure4: json["strMeasure4"],
      strMeasure5: json["strMeasure5"],
      strMeasure6: json["strMeasure6"],
      strMeasure7: json["strMeasure7"],
      strMeasure8: json["strMeasure8"],
      strMeasure9: json["strMeasure9"],
      strMeasure10: json["strMeasure10"],
      strMeasure11: json["strMeasure11"],
      strMeasure12: json["strMeasure12"],
      strMeasure13: json["strMeasure13"],
      strMeasure14: json["strMeasure14"],
      strMeasure15: json["strMeasure15"],
      strMeasure16: json["strMeasure16"],
      strMeasure17: json["strMeasure17"],
      strMeasure18: json["strMeasure18"],
      strMeasure19: json["strMeasure19"],
      strMeasure20: json["strMeasure20"]);

  Map<String, dynamic> toMap() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strSource": strSource,
        "strIngredient1": strIngredient1,
        "strIngredient2": strIngredient2,
        "strIngredient3": strIngredient3,
        "strIngredient4": strIngredient4,
        "strIngredient5": strIngredient5,
        "strIngredient6": strIngredient6,
        "strIngredient7": strIngredient7,
        "strIngredient8": strIngredient8,
        "strIngredient9": strIngredient9,
        "strIngredient10": strIngredient10,
        "strIngredient11": strIngredient11,
        "strIngredient12": strIngredient12,
        "strIngredient13": strIngredient13,
        "strIngredient14": strIngredient14,
        "strIngredient15": strIngredient15,
        "strIngredient16": strIngredient16,
        "strIngredient17": strIngredient17,
        "strIngredient18": strIngredient18,
        "strIngredient19": strIngredient19,
        "strIngredient20": strIngredient20,
        "strMeasure1": strMeasure1,
        "strMeasure2": strMeasure2,
        "strMeasure3": strMeasure3,
        "strMeasure4": strMeasure4,
        "strMeasure5": strMeasure5,
        "strMeasure6": strMeasure6,
        "strMeasure7": strMeasure7,
        "strMeasure8": strMeasure8,
        "strMeasure9": strMeasure9,
        "strMeasure10": strMeasure10,
        "strMeasure11": strMeasure11,
        "strMeasure12": strMeasure12,
        "strMeasure13": strMeasure13,
        "strMeasure14": strMeasure14,
        "strMeasure15": strMeasure15,
        "strMeasure16": strMeasure16,
        "strMeasure17": strMeasure17,
        "strMeasure18": strMeasure18,
        "strMeasure19": strMeasure19,
        "strMeasure20": strMeasure20
      };

  dynamic operator [](String propertyName) {
    switch (propertyName) {
      case "idMeal":
        return idMeal;
      case "strMeal":
        return strMeal;
      case "strCategory":
        return strCategory;
      case "strArea":
        return strArea;
      case "strInstructions":
        return strInstructions;
      case "strMealThumb":
        return strMealThumb;
      case "strTags":
        return strTags;
      case "strYoutube":
        return strYoutube;
      case "strSource":
        return strSource;
      case "strIngredient1":
        return strIngredient1;
      case "strIngredient2":
        return strIngredient2;
      case "strIngredient3":
        return strIngredient3;
      case "strIngredient4":
        return strIngredient4;
      case "strIngredient5":
        return strIngredient5;
      case "strIngredient6":
        return strIngredient6;
      case "strIngredient7":
        return strIngredient7;
      case "strIngredient8":
        return strIngredient8;
      case "strIngredient9":
        return strIngredient9;
      case "strIngredient10":
        return strIngredient10;
      case "strIngredient11":
        return strIngredient11;
      case "strIngredient12":
        return strIngredient12;
      case "strIngredient13":
        return strIngredient13;
      case "strIngredient14":
        return strIngredient14;
      case "strIngredient15":
        return strIngredient15;
      case "strIngredient16":
        return strIngredient16;
      case "strIngredient17":
        return strIngredient17;
      case "strIngredient18":
        return strIngredient18;
      case "strIngredient19":
        return strIngredient19;
      case "strIngredient20":
        return strIngredient20;
      case "strMeasure1":
        return strMeasure1;
      case "strMeasure2":
        return strMeasure2;
      case "strMeasure3":
        return strMeasure3;
      case "strMeasure4":
        return strMeasure4;
      case "strMeasure5":
        return strMeasure5;
      case "strMeasure6":
        return strMeasure6;
      case "strMeasure7":
        return strMeasure7;
      case "strMeasure8":
        return strMeasure8;
      case "strMeasure9":
        return strMeasure9;
      case "strMeasure10":
        return strMeasure10;
      case "strMeasure11":
        return strMeasure11;
      case "strMeasure12":
        return strMeasure12;
      case "strMeasure13":
        return strMeasure13;
      case "strMeasure14":
        return strMeasure14;
      case "strMeasure15":
        return strMeasure15;
      case "strMeasure16":
        return strMeasure16;
      case "strMeasure17":
        return strMeasure17;
      case "strMeasure18":
        return strMeasure18;
      case "strMeasure19":
        return strMeasure19;
      case "strMeasure20":
        return strMeasure20;
      default:
        return null;
    }
  }
}
