import 'package:dogs/models/breed.dart';


abstract class BreedListState {}

class InitialBreedListState extends BreedListState {}

class SuccessBreedListState extends BreedListState {
  final List<Breed> breeds;
  SuccessBreedListState(this.breeds);
}

class LoadingBreedListState extends BreedListState {}

class FailureBreedListState extends BreedListState {
  final String message;
  FailureBreedListState(this.message);
}