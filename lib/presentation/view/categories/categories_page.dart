import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/categories/viewmodel/categories_view_model.dart';
import 'package:food_app/presentation/view/meal_list/meal_list_page.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesViewModel _homeViewModel = inject<CategoriesViewModel>();
  List<MealCategory> _categories = [];

  @override
  void initState() {
    super.initState();

    _homeViewModel.getMealCategoriesState.stream.listen((state) {
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
            _homeViewModel.fetchMealsCategories();
          });
          break;
      }
    });

    _homeViewModel.fetchMealsCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //HACER GRID VIEW
        child: ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (_, index) {
              final category = _categories[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MealListPage(category: category.strCategory);
                    }));
                  },
                  child: Center(
                    child: Text(category.strCategory),
                  ),
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _homeViewModel.dispose();
  }
}
