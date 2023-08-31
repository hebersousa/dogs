import 'package:dogs/common/models/breed.dart';


abstract class FavoriteState {}

class InitialFavoriteState extends FavoriteState {}

class SuccessFavoriteState extends FavoriteState {
  final List<Breed> breeds;
  SuccessFavoriteState(this.breeds);
}

class LoadingFavoriteState extends FavoriteState {}

class FailureFavoriteState extends FavoriteState {
  final String message;
  FailureFavoriteState(this.message);
}