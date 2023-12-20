import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/header/header_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_row/meal_row.dart';
import 'package:food_app/presentation/widget/positioned_background/positioned_backgroud_element.dart';

class FavoriteMealsPage extends StatefulWidget {
  const FavoriteMealsPage({super.key});

  @override
  State<FavoriteMealsPage> createState() => _FavoriteMealsPageState();
}

class _FavoriteMealsPageState extends State<FavoriteMealsPage> {
  final MealsViewModel _favoriteListViewModel = inject<MealsViewModel>();
  List<Meal> _favoriteMealsList = [];

  @override
  void initState() {
    super.initState();

    _favoriteListViewModel.getFavoriteMealListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _favoriteMealsList = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _favoriteListViewModel.fetchFavoriteMealList();
          });
          break;
      }
    });

    _favoriteListViewModel.fetchFavoriteMealList();
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
                    title: "Favorite Meals",
                    message: "Taste your favorite foods again!"),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.builder(
                      itemCount: _favoriteMealsList.length,
                      itemBuilder: (_, index) {
                        final meal = _favoriteMealsList[index];
                        return Dismissible(
                          key: Key(meal.idMeal.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (_) {
                            _favoriteListViewModel.deleteFavoriteMeal(meal);
                          },
                          child: MealRow(
                            meal: meal,
                            route: NavigationRoutes.FAVORITES_DETAIL_ROUTE,
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
