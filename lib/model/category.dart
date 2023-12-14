import 'dart:convert';

CategoriesResponse categoriesResponseFromMap(String str) =>
    CategoriesResponse.fromMap(json.decode(str));

String categoriesResponseToMap(CategoriesResponse data) =>
    json.encode(data.toMap());

class CategoriesResponse {
  List<MealCategory> categories;

  CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromMap(Map<String, dynamic> json) =>
      CategoriesResponse(
        categories: List<MealCategory>.from(
            json["categories"].map((x) => MealCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
      };
}

class MealCategory {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  MealCategory({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory MealCategory.fromMap(Map<String, dynamic> json) => MealCategory(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toMap() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
