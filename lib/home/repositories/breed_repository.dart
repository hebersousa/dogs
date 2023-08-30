
import 'package:dogs/models/breed.dart';

abstract class  BreedRepository {
  Future<List<Breed>?> getAllBreeds();

  Future<List<String>?> getImages(String breed);

  Future<String> getImage(String breed);
}
