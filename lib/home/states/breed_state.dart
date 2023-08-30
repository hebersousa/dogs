import 'package:dogs/models/breed.dart';


abstract class BreedState {}

class InitialBreedState extends BreedState {}

class SuccessBreedState extends BreedState {
  final List<Breed> breeds;
  SuccessBreedState(this.breeds);
}

class LoadingBreedState extends BreedState {}

class ErrorBreedState extends BreedState {
  final String message;
  ErrorBreedState(this.message);
}