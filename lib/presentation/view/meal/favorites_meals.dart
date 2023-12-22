import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/presentation/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/provider/favorite_meal_provider.dart';
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
  final MealsViewModel _mealsViewModel = inject<MealsViewModel>();
  final FavoriteMealProvider _favoriteMealProvider =
      inject<FavoriteMealProvider>();

  @override
  void initState() {
    super.initState();

    _favoriteMealProvider.addListener(() {
      setState(() {});
    });

    _mealsViewModel.getFavoriteMealListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _favoriteMealProvider.updateFavoriteList(state.data!);
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealsViewModel.fetchFavoriteMealList();
          });
          break;
      }
    });

    _mealsViewModel.fetchFavoriteMealList();
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
                  child: _favoriteMealProvider.favoriteMealsList.isNotEmpty
                      ? ListView.builder(
                              itemCount: _favoriteMealProvider
                                  .favoriteMealsList.length,
                              itemBuilder: (_, index) {
                                final meal = _favoriteMealProvider
                                    .favoriteMealsList[index];
                                return Dismissible(
                                  key: Key(meal.idMeal.toString()),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    setState(() {
                                      _mealsViewModel.deleteFavoriteMeal(meal);
                                      _favoriteMealProvider
                                          .updateIsFavoriteMeal(false);
                                    });
                                  },
                                  child: MealRow(
                                    meal: meal,
                                    route:
                                        NavigationRoutes.FAVORITES_DETAIL_ROUTE,
                                  ),
                                );
                              })
                          .animate()
                          .slideX(duration: const Duration(milliseconds: 200))
                      : Column(
                          children: [
                            const SizedBox(height: 120),
                            Image.asset(
                              'assets/images/no_favorite_food.png',
                              height: 350,
                            ),
                            const Center(
                              child: Text(
                                "Add some foods to favorite!",
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
