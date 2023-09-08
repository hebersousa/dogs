
import 'package:dogs/common/models/breed.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_list_state.dart';
import 'package:flutter/cupertino.dart';

class BreedListStore extends ValueNotifier<BreedListState> {
  final BreedRepository repository;
  List<Breed>? breeds;

  BreedListStore(this.repository):super(InitialBreedListState());

  set filter(String filter) {
    if( value is SuccessBreedListState  ){
      value = LoadingBreedListState();
      if(filter.isNotEmpty) {
        value = SuccessBreedListState(breeds!
            .where((e) => e.name!.startsWith(filter)).toList());
      } else {
        value = SuccessBreedListState(breeds!);
      }

    }
  }


  Future fetchAllBreeds() async {
    value = LoadingBreedListState();
    try {
      var breeds = await repository.getAllBreeds();
      if (breeds != null) {
        this.breeds = breeds;
        value = SuccessBreedListState(breeds);
      }
    } catch (e) {
      value = FailureBreedListState(e.toString());
    }
  }



  Future<void> loadCoverImage(int index) async{
      if(value is SuccessBreedListState){
             var breeds = (value as SuccessBreedListState).breeds;
             var urlImage = await repository.getImage(breeds[index]);
             if(urlImage != null){
                 breeds[index].coverImage = urlImage;
                 value = SuccessBreedListState(breeds);
             }
      }
  }

}