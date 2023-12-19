import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/meal_detail/viewmodel/meal_detail_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';

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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: CachedNetworkImage(
                  imageUrl: _meal?.strMealThumb ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwZgTsV5FSzcygnwaRW4SePUSXSiNZCdYUhw&usqp=CAU",
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _meal?.strMeal ?? "N/A",
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
            Card(
              elevation: 4,
              surfaceTintColor: Colors.greenAccent,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 160,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _meal?.strInstructions ?? "Description not found",
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 4,
              surfaceTintColor: Colors.greenAccent,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _meal == null
                                ? const Text("Ingredients not found")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ingredients",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 2),
                                                Text(
                                                    "${_meal?.strIngredient1} - ${_meal?.strMeasure1}"),
                                                Text(
                                                    "${_meal?.strIngredient2} - ${_meal?.strMeasure2}"),
                                                Text(
                                                    "${_meal?.strIngredient3} - ${_meal?.strMeasure3}"),
                                                Text(
                                                    "${_meal?.strIngredient4} - ${_meal?.strMeasure4}"),
                                                Text(
                                                    "${_meal?.strIngredient5} - ${_meal?.strMeasure5}"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 2),
                                              Text(
                                                  "${_meal?.strIngredient6} - ${_meal?.strMeasure6}"),
                                              Text(
                                                  "${_meal?.strIngredient7} - ${_meal?.strMeasure7}"),
                                              Text(
                                                  "${_meal?.strIngredient8} - ${_meal?.strMeasure8}"),
                                              Text(
                                                  "${_meal?.strIngredient9} - ${_meal?.strMeasure9}"),
                                              Text(
                                                  "${_meal?.strIngredient10} - ${_meal?.strMeasure10}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
