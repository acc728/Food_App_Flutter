import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/utils/debouncer/text_field_debouncer.dart';
import 'package:food_app/presentation/view/categories/viewmodel/categories_view_model.dart';
import 'package:food_app/presentation/widget/category_row/category_row.dart';
import 'package:food_app/presentation/widget/custom_search_bar/custom_search_bar.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/header/header_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_row/meal_row.dart';
import 'package:food_app/presentation/widget/positioned_background/positioned_backgroud_element.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesViewModel _categoriesViewModel =
      inject<CategoriesViewModel>();
  List<MealCategory> _categories = [];

  final TextEditingController _searchController = TextEditingController();
  List<Meal> _searchMeals = [];
  bool searching = false;

  @override
  void initState() {
    super.initState();

    _categoriesViewModel.getMealCategoriesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            searching = false;
            _categories = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _categoriesViewModel.fetchMealsCategories();
          });
          break;
      }
    });

    _categoriesViewModel.getMealsByNameState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            searching = true;
            _searchMeals = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _categoriesViewModel.fetchMealsCategories();
          });
          break;
      }
    });

    _categoriesViewModel.fetchMealsCategories();
  }

  @override
  Widget build(BuildContext context) {
    final debouncer = TextFieldDebouncer(milliseconds: 1500, action: () {});

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const PositionedBackgroundElement(
                color1: Colors.greenAccent, color2: Colors.greenAccent),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderView(
                    title: "Search Food",
                    message: "Search foods or explore our list of categories!"),
                CustomSearchBar(
                    searchController: _searchController,
                    function: (text) {
                      debouncer.run(() {
                        text.isEmpty
                            ? _categoriesViewModel.fetchMealsCategories()
                            : _categoriesViewModel.fetchMealsByName(text);
                      });
                    }),
                const SizedBox(height: 10),
                !searching
                    ? Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (_, index) {
                              final category = _categories[index];
                              return CategoryRow(category: category);
                            }),
                      )
                    : _searchMeals.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: _searchMeals.length,
                                itemBuilder: (_, index) {
                                  final meal = _searchMeals[index];
                                  return MealRow(meal: meal);
                                }),
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 70),
                              Image.asset('assets/images/no_results.png'),
                              const Center(
                                child: Text(
                                  "Couldn't find any foods",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _categoriesViewModel.dispose();
  }
}
