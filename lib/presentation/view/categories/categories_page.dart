import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal_category.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/view/categories/viewmodel/home_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final HomeViewModel _homeViewModel = inject<HomeViewModel>();
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
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: SafeArea(
        //HACER GRID VIEW
        child: ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (_, index) {
              final category = _categories[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    context.go(NavigationRoutes.CATEGORY_MEAL_LIST_ROUTE,
                        extra: category.strCategory);
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
