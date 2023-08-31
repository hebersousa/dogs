import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_list_state.dart';
import 'package:dogs/home/stores/breed_list_store.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class BreedRepositoryMock extends Mock implements BreedRepository {}

void main(){
  final repository = BreedRepositoryMock();
  final store = BreedListStore(repository);
  tearDown(() => reset(repository));



  group('fetchBreeds - ', () {
    test('should get all breeds', () async {
      when(()=> repository.getAllBreeds())
          .thenAnswer((_) async => [Breed(name: "akita"),Breed(name: "beagle")]);

      await expectLater(store.fetchAllBreeds(), completes );
      BreedListState value = store.value;
      expect(  value is SuccessBreedListState, true);
      expect(  (value as SuccessBreedListState).breeds.isNotEmpty , true );

    });

    test('should return a error state', () async {
      when(()=> repository.getAllBreeds()).thenThrow(Exception('error'));
      await expectLater(store.fetchAllBreeds(), completes );
      BreedListState value = store.value;
      expect(  value is FailureBreedListState, true);

    });
    
  });

}