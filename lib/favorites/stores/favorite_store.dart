

import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/favorites/states/favorite_state.dart';
import 'package:flutter/widgets.dart';

class FavoriteStore extends ValueNotifier<FavoriteState> {
    final LocalDataService repository;

    FavoriteStore(this.repository):super(InitialFavoriteState());

    Future<void> fetchAll() async {
      value = LoadingFavoriteState();
      try {
        var breeds = await repository.getFavorites();
        if (breeds != null) {
          value = SuccessFavoriteState(breeds);
        }
      } catch (e) {
        value = FailureFavoriteState(e.toString());
      }
    }

    Future<void> check(Breed breed) async {
      late List<Breed> list;
      if(has(breed)) {
          list = await repository.remove(breed);
      } else {


         list = await repository.add(breed);
      }
      value = SuccessFavoriteState(list);
    }

    bool has(Breed breed) {
      if(value is SuccessFavoriteState ){
          var breeds = (value as SuccessFavoriteState).breeds;
          return  breeds.any((e) => e.name == breed.name);
      }
      return false;
    }

}