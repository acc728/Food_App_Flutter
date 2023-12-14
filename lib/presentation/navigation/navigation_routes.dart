import 'package:food_app/presentation/view/categories/categories_page.dart';
import 'package:food_app/presentation/view/meal_list/meal_list_page.dart';
import 'package:food_app/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class NavigationRoutes {
  // Routes
  static const String SPLASH_ROUTE = "/";
  static const String MEAL_CATEGORIES_ROUTE = "/meal-categories";
  static const String CATEGORY_MEAL_LIST_ROUTE =
      "$MEAL_CATEGORIES_ROUTE/$_MEAL_LIST_PATH";

  // Paths
  static const String _MEAL_LIST_PATH = "meal-list";
}

final GoRouter router =
    GoRouter(initialLocation: NavigationRoutes.SPLASH_ROUTE, routes: [
  GoRoute(
      path: NavigationRoutes.SPLASH_ROUTE,
      builder: (context, state) => const SplashPage()),
  GoRoute(
      path: NavigationRoutes.MEAL_CATEGORIES_ROUTE,
      builder: (context, state) => const CategoriesPage(),
      routes: [
        GoRoute(
            path: NavigationRoutes._MEAL_LIST_PATH,
            builder: (context, state) =>
                MealListPage(category: state.extra as String))
      ]),
]);
