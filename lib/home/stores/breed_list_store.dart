
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_list_state.dart';
import 'package:dogs/models/breed.dart';
import 'package:flutter/cupertino.dart';

class BreedListStore extends ValueNotifier<BreedListState> {
  final BreedRepository repository;

  BreedListStore(this.repository):super(InitialBreedListState());

  Future fetchAllBreeds() async {
    value = LoadingBreedListState();
    try {
      var breeds = await repository.getAllBreeds();
      if (breeds != null) {
        value = SuccessBreedListState(breeds);
      }
    } catch (e) {
      value = FailureBreedListState(e.toString());
    }
  }

  Future<void> checkBreed(Breed breed) async {}

}