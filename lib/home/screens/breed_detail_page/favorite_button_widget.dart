import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/common/services/service_locator.dart';
import 'package:dogs/favorites/states/favorite_state.dart';
import 'package:dogs/favorites/stores/favorite_store.dart';
import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final Breed breed;
  bool onlyIcon = true;
   FavoriteButtonWidget({required this.breed, this.onlyIcon = true, Key? key}) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  final FavoriteStore store = locator<FavoriteStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.fetchAll();
    });

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
    Icon icon = Icon(iconData,color: Colors.red.shade800,);
    var action = disable ? null : ()=> store.check(widget.breed);
    return  widget.onlyIcon ?
          IconButton(onPressed: action, icon: icon)
          : InkWell(onTap:  action,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _subtitle(widget.breed.name!),
              const SizedBox(width: 5,),
              icon],
          ),
    );
  }


  _subtitle(String name) {
    var capitalized =  name[0].toUpperCase() + name.substring(1);
    var style =  const TextStyle(fontSize: 26, color: Colors.black38);
    return Text(capitalized, style:style );
  }

}
