import 'dart:io';
import 'package:dogs/models/breed.dart';
import 'package:dogs/services/hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

main() {
  var path = Directory.current.path;
  Hive.init(path);
  var service = HiveService();

  test('test hive serfice', ()  async{

    var save = service.saveFavorites([Breed(name: 'beagle')]);
    expect(save, completes);

    var recover = service.getFavorites();
    expect(recover, completion(equals([Breed(name: 'beagle')])));


  });
}