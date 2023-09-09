

import 'dart:typed_data';

import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/favorites/states/favorite_state.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/stores/breed_store.dart';
import 'package:flutter/widgets.dart';

class FavoriteStore extends ValueNotifier<FavoriteState> {
    final LocalDataService localRepository;
    final BreedRepository breedRepository;

    FavoriteStore(this.localRepository, this.breedRepository):super(InitialFavoriteState());

    Future<void> fetchAll() async {
      value = LoadingFavoriteState();
      try {
        var breeds = await localRepository.getFavorites();
        if (breeds != null) {
          value = SuccessFavoriteState(breeds);
        }
      } catch (e) {
        value = FailureFavoriteState(e.toString());
      }
    }

    Future<void> check(Breed breed) async {
      late List<Breed> list;
      print(breed.toString());
      if(has(breed)) {
          list = await localRepository.remove(breed);
      } else {

        var images = await breedRepository.getImages(breed);
        var imageBytes = <Uint8List>[];
        if(images!=null){
          for( final url in images.take(5)){
              var byteList = await breedRepository.downloadImage(url);
              imageBytes.add(byteList);
          }
        }
        breed.imageBytes = imageBytes;


         list = await localRepository.add(breed);
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