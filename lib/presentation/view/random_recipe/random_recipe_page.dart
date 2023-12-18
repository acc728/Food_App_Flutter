import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/random_recipe/viewmodel/random_recipe_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';

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
          child: Column(
        children: [
          Text(_randomRecipe?.strMeal ?? "N/A"),
          Image.network(_randomRecipe?.strMealThumb ??
              "https://static.wixstatic.com/media/bf242e_6133b4ae6a104cc2b50d70179f35efea~mv2.jpg/v1/fill/w_500,h_374,al_c,lg_1,q_80,enc_auto/food-placeholder.jpg")
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _randomRecipeViewModel.fetchRandomRecipe();
        },
        label: const Flexible(child: Text("New Recipe")),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _randomRecipeViewModel.dispose();
  }
}
