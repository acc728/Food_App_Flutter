import 'package:food_app/data/meal/meal_data_impl.dart';
import 'package:food_app/data/meal/remote/meal_remote_impl.dart';
import 'package:food_app/data/remote/network_client.dart';
import 'package:food_app/domain/meals_repository.dart';
import 'package:food_app/presentation/view/home/viewmodel/home_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupJokeModule();
  }

  _setupMainModule() {
    inject.registerSingleton(NetworkClient());
  }

  _setupJokeModule() {
    inject.registerFactory(() => MealRemoteImpl(networkClient: inject.get()));

    inject.registerFactory<MealRepository>(
        () => MealDataImpl(remoteImpl: inject.get()));

    inject.registerFactory(() => HomeViewModel(mealsRepository: inject.get()));
  }
}