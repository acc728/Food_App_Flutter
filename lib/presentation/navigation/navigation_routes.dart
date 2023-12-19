import 'package:food_app/presentation/view/categories/categories_page.dart';
import 'package:food_app/presentation/view/home/home_page.dart';
import 'package:food_app/presentation/view/meal_list/meal_list_page.dart';
import 'package:food_app/presentation/view/random_recipe/random_recipe_page.dart';
import 'package:food_app/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class NavigationRoutes {
  static const SPLASH_ROUTE = "/splash";
  static const CATEGORIES_ROUTE = "/categories";
  static const MEAL_LIST_ROUTE = "$CATEGORIES_ROUTE/$_MEAL_LIST_PATH";
  static const RANDOM_RECIPE_ROUTE = "/random-recipe";
  static const FAVS_ROUTE = "/favorites";

  static const _MEAL_LIST_PATH = "meal-list";
}

final GoRouter router =
    GoRouter(initialLocation: NavigationRoutes.SPLASH_ROUTE, routes: [
  GoRoute(
    path: NavigationRoutes.SPLASH_ROUTE,
    builder: (context, state) => const SplashPage(),
  ),
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomePage(
            navigationShell: navigationShell,
          ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.CATEGORIES_ROUTE,
            builder: (context, state) => const CategoriesPage(),
            routes: [
              GoRoute(
                path: NavigationRoutes._MEAL_LIST_PATH,
                builder: (context, state) => MealListPage(
                  category: state.extra as String,
                ),
              )
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.RANDOM_RECIPE_ROUTE,
            builder: (context, state) => const RandomRecipePage(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavigationRoutes.FAVS_ROUTE,
            builder: (context, state) => const CategoriesPage(),
          )
        ])
      ])
]);
