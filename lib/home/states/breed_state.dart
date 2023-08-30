import 'package:dogs/models/breed.dart';


abstract class BreedState {}

class InitialBreedState extends BreedState {}

class SuccessBreedState extends BreedState {
  final Breed breed;
  SuccessBreedState(this.breed);
}

class LoadingBreedState extends BreedState {}

class FailureBreedState extends BreedState {
  final String message;
  FailureBreedState(this.message);
}