import 'package:food_app/data/meal/local/meal_local_impl.dart';
import 'package:food_app/data/meal/meal_data_impl.dart';
import 'package:food_app/data/meal/remote/meal_remote_impl.dart';
import 'package:food_app/data/remote/network_client.dart';
import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/presentation/provider/favorite_meal_provider.dart';
import 'package:food_app/presentation/view/meal/viewmodel/meals_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupMealModule();
  }

  _setupMainModule() {
    inject.registerSingleton(NetworkClient());
  }

  _setupMealModule() {
    inject.registerSingleton(FavoriteMealProvider());

    inject.registerFactory(() => MealRemoteImpl(networkClient: inject.get()));
    inject.registerFactory(() => MealLocalImpl());

    inject.registerFactory<MealRepository>(
        () => MealDataImpl(remoteImpl: inject.get(), localImpl: inject.get()));

    inject.registerFactory(() => MealsViewModel(mealsRepository: inject.get()));
  }
}
