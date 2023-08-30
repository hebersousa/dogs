
import 'package:dogs/home/breed_ds.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:flutter/cupertino.dart';

class BreedStore extends ValueNotifier<BreedState> {
  BreedStore():super(InitialBreedState());

  Future fetchAllBreeds() async {
    var ds = BreedDataSource();
    value = LoadingBreedState();
    try {
      var breeds = await ds.getAllBreeds();
      if (breeds != null) {
        value = SuccessBreedState(breeds);
      }
    } catch (e) {
      value = ErrorBreedState(e.toString());
    }
  }
}