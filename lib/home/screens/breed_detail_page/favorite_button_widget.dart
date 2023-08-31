import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/favorites/states/favorite_state.dart';
import 'package:dogs/favorites/stores/favorite_store.dart';
import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final Breed breed;
  bool onlyIcon = false;
   FavoriteButtonWidget({required this.breed, this.onlyIcon = false, Key? key}) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  final FavoriteStore store = FavoriteStore(LocalDataService());

  @override
  void initState() {
    super.initState();
    store.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }


  Widget _body() {

    return ValueListenableBuilder<FavoriteState>(
        valueListenable: store,
        builder:(context, state, child) {
          if(state is SuccessFavoriteState){
              if( store.has(widget.breed)){
                  return _button(iconData: Icons.favorite);
              } else {
                  return _button(iconData: Icons.favorite_border);
              }
          }
          return  _button(iconData: Icons.favorite_border, disable: true);
        });
  }

  _button( {required IconData iconData, bool disable = false, }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: IconButton(onPressed:  disable ? null : ()=> store.check(widget.breed),

        icon:
                Icon(iconData,color: Colors.red.shade800,)
            )
    );
  }

}
