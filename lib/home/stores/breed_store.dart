
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:dogs/models/breed.dart';
import 'package:flutter/cupertino.dart';

class BreedStore extends ValueNotifier<BreedState> {
  final BreedRepository repository;

  BreedStore(this.repository):super(InitialBreedState());




  Future fetchAllBreeds() async {
    value = LoadingBreedState();
    try {
      var breeds = await repository.getAllBreeds();
      if (breeds != null) {
        value = SuccessBreedState(breeds);
      }
    } catch (e) {
      value = FailureBreedState(e.toString());
    }
  }

  Future<void> checkBreed(Breed breed) async {}

}