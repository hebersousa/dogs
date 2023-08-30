import 'dart:io';

import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:dogs/home/stores/breed_store.dart';
import 'package:dogs/models/breed.dart';
import 'package:dogs/services/hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class BreedRepositoryMock extends Mock implements BreedRepository {}

void main(){
  final repository = BreedRepositoryMock();
  final store = BreedStore(repository);
  tearDown(() => reset(repository));



  group('fetchBreeds - ', () {
    test('should get all breeds', () async {
      when(()=> repository.getAllBreeds())
          .thenAnswer((_) async => [Breed(name: "akita"),Breed(name: "beagle")]);

      await expectLater(store.fetchAllBreeds(), completes );
      BreedState value = store.value;
      expect(  value is SuccessBreedState, true);
      expect(  (value as SuccessBreedState).breeds.isNotEmpty , true );

    });

    test('should return a error state', () async {
      when(()=> repository.getAllBreeds()).thenThrow(Exception('error'));
      await expectLater(store.fetchAllBreeds(), completes );
      BreedState value = store.value;
      expect(  value is FailureBreedState, true);

    });
    
  });

}