import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/meal_detail/viewmodel/meal_detail_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/ingredients_scroll_view/ingredients_scroll_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';
import 'package:food_app/presentation/widget/meal_description_card/meal_description_card.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key, required this.id});

  final String id;

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final MealDetailViewModel _mealDetailViewModel =
      inject<MealDetailViewModel>();
  Meal? _meal;

  @override
  void initState() {
    super.initState();

    _mealDetailViewModel.getMealState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _meal = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _mealDetailViewModel.fetchMealDetails(widget.id);
          });
          break;
      }
    });

    _mealDetailViewModel.fetchMealDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detail",
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: _meal != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
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
            const SizedBox(height: 20),
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
                  _meal?.strTags ?? "This meals has no tags",
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
              )
          ],
        ),
      ),
    );
  }
}
