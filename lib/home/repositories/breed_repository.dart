
import 'package:dogs/common/models/breed.dart';
import 'package:flutter/foundation.dart';

abstract class  BreedRepository {
  Future<List<Breed>?> getAllBreeds();

  Future<List<String>?> getImages(Breed breed);

  Future<String?> getImage(Breed breed);

  Future<Uint8List> downloadImage(String imageUrl);
}
