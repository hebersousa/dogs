
import 'package:dogs/models/breed.dart';
import 'package:dogs/api/my_http_client.dart';

class BreedDataSource {


  Future<List<Breed>?> getAllBreeds() async {
    var api = MyHttpClient();

      var url = "https://dog.ceo/api/breeds/list/all";
      var result = await api.get(url);
      var breeds = List<Breed>.from(result["message"].keys.map((v)=> Breed.fromJson({"name":v})));
      return Future.value(breeds);
  }

  Future<List<String>?> getImages(String breed) async {
    var api = MyHttpClient();

    try {
      var url = "https://dog.ceo/api/breed/$breed/images";
      var result = await api.get(url);
      var images = List<String>.from(result["message"]);
      return Future.value(images);

    } catch(e) {
      print(e);
    }
  }


  Future<String> getImage(String breed) async {
    var api = MyHttpClient();
    var image_error = "https://dog.ceo/img/dog-api-logo.svg";

    try {
      var url = "https://dog.ceo/api/breed/$breed/images/random";
      var result = await api.get(url);
      if(result.containsValue("success")) {
        return Future.value(result["message"]);
      }
      return Future.value(image_error);

    } catch(e) {
      return Future.value(image_error);
    }
  }



}