import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/presentation/model/resource_state.dart';
import 'package:food_app/presentation/provider/favorite_meal_provider.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/ingredients_scroll_view/ingredients_scroll_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_description_card/meal_description_card.dart';
import 'package:google_fonts/google_fonts.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key, required this.id});

  final String id;
  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final MealsViewModel _mealsViewModel = inject<MealsViewModel>();
  final FavoriteMealProvider _mealProvider = inject<FavoriteMealProvider>();
  Meal? _meal;

  @override
  void initState() {
    super.initState();

    _mealProvider.addListener(() {
      if (mounted) setState(() {});
    });

    _mealsViewModel.getMealState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _meal = state.data!;
            _mealsViewModel.isFavoriteMeal(_meal!);
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealsViewModel.fetchMealDetails(widget.id);
          });
          break;
      }
    });

    _mealsViewModel.getMealIsFavoriteState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _mealProvider.updateIsFavoriteMeal(state.data!);
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealsViewModel.fetchMealDetails(widget.id);
          });
          break;
      }
    });

    _mealsViewModel.fetchMealDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Detail",
              style: GoogleFonts.pacifico(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _mealProvider.isFavoriteMeal
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 35,
                ),
                onPressed: () {
                  if (_mealProvider.isFavoriteMeal) {
                    setState(() {
                      _mealsViewModel.deleteFavoriteMeal(_meal!);
                    });
                  } else {
                    setState(() {
                      _mealsViewModel.addFavoriteMeal(_meal!);
                    });
                  }
                },
              )
            ]),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: _meal != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: CachedNetworkImage(
                        imageUrl: _meal!.strMealThumb,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    )
                  : Image.asset(
                      'assets/images/food_placeholder.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 15),
            if (_meal != null)
              Center(
                child: Text(
                  _meal?.strMeal ?? "N/A",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (_meal?.strTags != null)
              Center(
                child: Text(
                  _meal?.strTags?.replaceAll(',', ", ") ??
                      "This meals has no tags",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            const Divider(
              thickness: 1,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            MealDescriptionCard(
              meal: _meal,
            ),
            if (_meal != null)
              IngredientsScrollView(
                meal: _meal,
              ),
          ]),
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
