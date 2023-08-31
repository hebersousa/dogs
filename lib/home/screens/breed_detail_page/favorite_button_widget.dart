import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class FavoriteButtonWidget extends StatefulWidget {
  final Breed breed;
  const FavoriteButtonWidget({required this.breed, Key? key}) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  HiveService hiveService = HiveService();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _future();
  }

  _button( {required String text, required Function? onPressed}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: ElevatedButton(
          onPressed: onPressed==null ? null : ()=> onPressed(),
          child:  Text(text),
    ));

  }

  _future(){
    return FutureBuilder(
        future: hiveService.loadBox(),
        builder: (context,shot){
          var state = shot.connectionState;
          if(shot.hasData && state == ConnectionState.done) {
                return _observer();
          }
          return _button(
              text: 'Add to Favorite',
              onPressed: null
          );
    });
  }

    _addBreed ()=> hiveService.add(widget.breed);
    _removeBreed()=> hiveService.remove(widget.breed);

  _observer() {
    return ValueListenableBuilder(
        valueListenable: hiveService.listenable()!,

        builder: (context, box, _) {
               var fav = box.get('favorites');

               var list = fav!= null?  (json.decode(fav) as List)
                   .map((data) => Breed.fromJson(data)).toList()
                   : [];

               if( list.any((e) => e.name == widget.breed.name)){
                 return _button(text: 'Remove from Favorites',onPressed: ()=>_removeBreed());
               }

          return _button(text: 'Add to Favorites',onPressed: ()=> _addBreed());

        });
  }



}
