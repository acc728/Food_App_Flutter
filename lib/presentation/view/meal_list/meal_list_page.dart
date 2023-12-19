import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/view/meal_list/viewmodel/meal_list_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_row/meal_row.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({super.key, required this.category});

  final String category;

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final MealListViewModel _mealListViewModel = inject<MealListViewModel>();
  List<Meal> _mealListByCategory = [];
  String _category = "";

  @override
  void initState() {
    super.initState();

    _mealListViewModel.getMealListByCategoryState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _mealListByCategory = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealListViewModel.fetchMealListByCategory(widget.category);
          });
          break;
      }
    });

    _mealListViewModel.fetchMealListByCategory(widget.category);
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          _category,
          style: const TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _mealListByCategory.length,
            itemBuilder: (_, index) {
              final meal = _mealListByCategory[index];
              return MealRow(
                meal: meal,
                route: NavigationRoutes.MEAL_DETAIL_ROUTE,
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mealListViewModel.dispose();
  }
}
