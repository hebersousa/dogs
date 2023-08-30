
import 'dart:convert';

import 'package:dogs/models/breed.dart';
import 'package:hive/hive.dart';
class HiveService {

  Future<List<Breed>> getFavorites() async {
    var box = await Hive.openBox('breeds');
    var fav =  box.get('favorites');
    var data = (json.decode(fav) as List)
        .map((data) => Breed.fromJson(data)).toList();
    return  List<Breed>.from(data);
  }

  saveFavorites(List<Breed> breeds) async {
    var box = await Hive.openBox('breeds');

    box.put('favorites', json.encode(breeds));
  }


}


