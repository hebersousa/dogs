
import 'package:dogs/models/breed.dart';

abstract class  BreedRepository {
  Future<List<Breed>?> getAllBreeds();

  Future<List<String>?> getImages(Breed breed);

  Future<String> getImage(Breed breed);
}
