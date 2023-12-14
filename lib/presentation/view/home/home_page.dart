import 'package:flutter/material.dart';
import 'package:food_app/di/app_modules.dart';
import 'package:food_app/model/category.dart';
import 'package:food_app/model/resource_state.dart';
import 'package:food_app/presentation/view/home/viewmodel/home_view_model.dart';
import 'package:food_app/presentation/widget/error/error_view.dart';
import 'package:food_app/presentation/widget/loading/loading_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = inject<HomeViewModel>();
  List<MealCategory> _categories = [];

  @override
  void initState() {
    super.initState();

    _homeViewModel.getMealCategoriesState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingView.show(context);
          break;
        case Status.SUCCESS:
          LoadingView.hide();
          setState(() {
            _categories = state.data!;
          });
          break;
        case Status.ERROR:
          LoadingView.hide();
          ErrorView.show(context, state.exception!.toString(), () {
            _homeViewModel.fetchMealsCategories();
          });
          break;
      }
    });

    _homeViewModel.fetchMealsCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (_, index) {
              final category = _categories[index];
              return ListTile(
                title: Text(category.strCategory),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _homeViewModel.dispose();
  }
}
