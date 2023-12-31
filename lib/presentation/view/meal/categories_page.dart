import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/presentation/model/resource_state.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:food_app/presentation/widget/category_row/category_row.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/header/header_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/positioned_background/positioned_backgroud_element.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final MealsViewModel _mealsViewModel = inject<MealsViewModel>();
  List<MealCategory> _categories = [];

  @override
  void initState() {
    super.initState();

    _mealsViewModel.getMealCategoriesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _categories = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealsViewModel.fetchMealsCategories();
          });
          break;
      }
    });

    _mealsViewModel.fetchMealsCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const PositionedBackgroundElement(
                color1: Colors.greenAccent, color2: Colors.greenAccent),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderView(
                    title: "Categories",
                    message: "Explore our list of categories to find foods!"),
                const SizedBox(height: 4),
                Expanded(
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
    _mealsViewModel.dispose();
  }
}
