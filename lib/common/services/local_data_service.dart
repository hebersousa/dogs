
import 'dart:convert';

import 'package:dogs/common/models/breed.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataService {


  Future<List<Breed>> getFavorites() async {
    var box = await Hive.openBox('breeds');
    var fav =  box.get('favorites');
    if( fav == null) {
        return Future.value(<Breed>[]);
    }
    var data = (json.decode(fav) as List)
        .map((data) => Breed.fromJson(data)).toList();
    return Future.value(data);
  }

  Future<void> _save(List<Breed> breeds) async {
      var box = await Hive.openBox('breeds');
      box.put('favorites', json.encode(breeds));
  }

  Future<List<Breed>> add(Breed breed) async{
    var favorites = await getFavorites();
    if( !favorites.any((e) => e.name == breed.name)){
      favorites.add(breed);
      await _save(favorites);
    }
    return Future.value(favorites);
  }

  Future<List<Breed>> remove(Breed breed) async{
    var favorites = await getFavorites();
    favorites.removeWhere((e) => e.name == breed.name);
    await _save(favorites);

    return Future.value(favorites);
  }


}


