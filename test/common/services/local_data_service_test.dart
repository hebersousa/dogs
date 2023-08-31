import 'dart:io';
import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() {

  Hive.init( Directory.current.path);

  var service = LocalDataService();

  group("Hive service tests", () {
    test('should try add duplicate breeds but return only one', ()  async {
      await Hive.deleteBoxFromDisk('breeds');
      await expectLater(service.add(Breed(name: 'beagle')), completes);
      await expectLater(service.add(Breed(name: 'beagle')), completes);

      var recover =    service.getFavorites();
       expect(recover, completion(equals([Breed(name: 'beagle')])));

    });

    test('should add a new breed and recover a list of breeds', ()  async {
      await Hive.deleteBoxFromDisk('breeds');
      await service.add(Breed(name: 'beagle'));
      await service.add(Breed(name: 'akita'));

      var recover = await service.getFavorites();
      expectLater(recover, equals([Breed(name: 'beagle'),Breed(name: 'akita')]));

    });


    test("should remove a breed called beagle", () async {
      await Hive.deleteBoxFromDisk('breeds');
      await service.add(Breed(name: 'beagle'));
      await service.add(Breed(name: 'akita'));
      await service.remove(Breed(name: 'beagle'));

      var recover = service.getFavorites();
      expectLater(recover, completion(equals([Breed(name: 'akita')])));
    });


  });


}