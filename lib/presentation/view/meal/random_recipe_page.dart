import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/model/resource_state.dart';
import 'package:food_app/presentation/navigation/navigation_routes.dart';
import 'package:food_app/presentation/utils/debouncer/text_field_debouncer.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:food_app/presentation/widget/custom_search_bar/custom_search_bar.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/header/header_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_row/meal_row.dart';
import 'package:food_app/presentation/widget/positioned_background/positioned_backgroud_element.dart';
import 'package:food_app/presentation/widget/recipe_card/recipe_card.dart';

class RandomRecipePage extends StatefulWidget {
  const RandomRecipePage({super.key});

  @override
  State<RandomRecipePage> createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  final MealsViewModel _mealsViewModel = inject<MealsViewModel>();
  Meal? _randomRecipe;

  final TextEditingController _searchController = TextEditingController();
  List<Meal> _searchMeals = [];
  bool searching = false;

  @override
  void initState() {
    super.initState();

    _mealsViewModel.getRandomRecipeState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            searching = false;
            _randomRecipe = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealsViewModel.fetchRandomRecipe();
          });
          break;
      }
    });

    _mealsViewModel.getMealsByNameState.stream.listen((state) {
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
            _mealsViewModel.fetchRandomRecipe();
          });
          break;
      }
    });

    _mealsViewModel.fetchRandomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    final debouncer = TextFieldDebouncer(milliseconds: 1500, action: () {});

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          const PositionedBackgroundElement(
              color1: Colors.greenAccent, color2: Color(0xFF69F0AE)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderView(
                  title: 'Find Foods',
                  message: 'Save time thinking what to cook today!'),
              CustomSearchBar(
                  searchController: _searchController,
                  onChangedFunction: (text) {
                    debouncer.run(() {
                      text.isEmpty
                          ? setState(() {
                              searching = false;
                            })
                          : _mealsViewModel.fetchMealsByName(text);
                    });
                  }),
              const SizedBox(height: 4),
              !searching
                  ? Expanded(child: RecipeCard(meal: _randomRecipe))
                      .animate()
                      .slideX()
                  : _searchMeals.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                                  itemCount: _searchMeals.length,
                                  itemBuilder: (_, index) {
                                    final meal = _searchMeals[index];
                                    return MealRow(
                                      meal: meal,
                                      route: NavigationRoutes
                                          .RANDOM_MEAL_DETAIL_ROUTE,
                                    );
                                  })
                              .animate()
                              .slideX(
                                  duration: const Duration(milliseconds: 200)),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 120),
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
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.refresh),
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            _mealsViewModel.fetchRandomRecipe();
          },
          label: const Flexible(
              child: Text(
            "New Recipe",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
          )),
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
