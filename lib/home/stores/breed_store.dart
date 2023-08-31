
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:flutter/material.dart';

class BreedStore extends ValueNotifier<BreedState> {
  final BreedRepository repository;

  BreedStore(this.repository):super(InitialBreedState());

  Future fetchImages(Breed breed) async {
    value = LoadingBreedState();
    try {
      var images = await repository.getImages(breed);
      if (images != null && images is List<String>) {
        breed.images = images;
        value = SuccessBreedState(breed);
      }
    } catch (e) {
      value = FailureBreedState(e.toString());
    }
  }



}