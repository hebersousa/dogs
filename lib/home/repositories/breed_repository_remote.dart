
import 'dart:async';

import 'package:dogs/home/repositories/breed_repository.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/api/my_http_client.dart';
import 'package:flutter/foundation.dart';

class BreedRepositoryRemote extends BreedRepository {

  @override
  Future<List<Breed>?> getAllBreeds() async {
    var api = MyHttpClient();

    var url = "https://dog.ceo/api/breeds/list/all";
    var result = await api.get(url);
    var breeds = List<Breed>.from(
        result["message"].keys.map((v) => Breed.fromJson({"name": v})));
    return Future.value(breeds);
  }
  @override
  Future<List<String>?> getImages(Breed breed) async {
    var api = MyHttpClient();

    var url = "https://dog.ceo/api/breed/${breed.name}/images";
    var result = await api.get(url);
    var images = List<String>.from(result["message"]);
    return Future.value(images);
  }

  @override
  Future<String?> getImage(Breed breed) async {
    var api = MyHttpClient();

    var url = "https://dog.ceo/api/breed/${breed.name}/images/random";
    var result = await api.get(url);
    if (result.containsValue("success")) {
      return Future.value(result["message"]);
    }
    return Future.value();
  }

  @override
  Future<Uint8List> downloadImage(String imageUrl) async {
    var api = MyHttpClient();

    Uint8List image = await  api.downloadImage(imageUrl);
    return Future.value(image);
  }
}