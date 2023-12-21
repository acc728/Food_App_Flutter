import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_row/meal_row.dart';
import 'package:google_fonts/google_fonts.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({super.key, required this.category});

  final String category;

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final MealsViewModel _mealsViewModel = inject<MealsViewModel>();
  List<Meal> _mealListByCategory = [];
  String _category = "";

  @override
  void initState() {
    super.initState();

    _mealsViewModel.getMealListByCategoryState.stream.listen((state) {
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
            _mealsViewModel.fetchMealListByCategory(widget.category);
          });
          break;
      }
    });

    _mealsViewModel.fetchMealListByCategory(widget.category);
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _category,
          style: GoogleFonts.pacifico(
              fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: _mealListByCategory.length,
          itemBuilder: (_, index) {
            final meal = _mealListByCategory[index];
            return MealRow(
              meal: meal,
              route: NavigationRoutes.MEAL_DETAIL_ROUTE,
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mealsViewModel.dispose();
  }
}
