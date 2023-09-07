import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/favorites/stores/favorite_store.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/stores/breed_list_store.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;


void setupLocator() {

  locator.registerLazySingleton<BreedListStore>(() => BreedListStore(BreedRepositoryRemote()));
  locator.registerLazySingleton<FavoriteStore>(() => FavoriteStore(LocalDataService()));
}