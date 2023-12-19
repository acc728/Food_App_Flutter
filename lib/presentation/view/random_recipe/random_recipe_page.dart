import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/random_recipe/viewmodel/random_recipe_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/header/header_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/positioned_background/positioned_backgroud_element.dart';
import 'package:food_app/presentation/widget/recipe_card/recipe_card.dart';

class RandomRecipePage extends StatefulWidget {
  const RandomRecipePage({super.key});

  @override
  State<RandomRecipePage> createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  final RandomRecipeViewModel _randomRecipeViewModel =
      inject<RandomRecipeViewModel>();
  Meal? _randomRecipe;

  @override
  void initState() {
    super.initState();

    _randomRecipeViewModel.getRandomRecipeState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _randomRecipe = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _randomRecipeViewModel.fetchRandomRecipe();
          });
          break;
      }
    });

    _randomRecipeViewModel.fetchRandomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          const PositionedBackgroundElement(
              color1: Colors.greenAccent, color2: Colors.greenAccent),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderView(
                  title: 'Random Recipe',
                  message: 'Save time thinking what to cook today!'),
              const Spacer(),
              RecipeCard(meal: _randomRecipe),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: FloatingActionButton.extended(
                    icon: const Icon(Icons.refresh),
                    backgroundColor: Colors.greenAccent,
                    onPressed: () {
                      _randomRecipeViewModel.fetchRandomRecipe();
                    },
                    label: const Flexible(
                        child: Text(
                      "New Recipe",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _randomRecipeViewModel.dispose();
  }
}
