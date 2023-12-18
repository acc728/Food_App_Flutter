import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/meal_list/viewmodel/meal_list_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({super.key, required this.category});

  final String category;

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final MealListViewModel _mealListViewModel = inject<MealListViewModel>();
  List<Meal> _mealListByCategory = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _mealListByCategory.length,
            itemBuilder: (_, index) {
              final meal = _mealListByCategory[index];
              return ListTile(
                title: Text(meal.strMeal),
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
