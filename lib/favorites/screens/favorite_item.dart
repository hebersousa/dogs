import 'package:dogs/common/widgets/rounded_cached_image.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  final Breed breed;
  final Function onPressed;
  const FavoriteItem({Key? key, required  this.breed, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   _content();
  }


  _content() {
    return Column(children: [
      _header(),
      _listImages()
    ]);

  }

  _header() {
    return Row(children: [
      Expanded(child:  _subtitle(breed.name!)),
      IconButton(icon: const Icon(Icons.remove_circle,color: Colors.red,), onPressed: () => onPressed(),)
    ]);
  }



  _listImages(){
    return SizedBox(height: 150,
      child: ListView(scrollDirection: Axis.horizontal,
      children: breed.images?.
  map((url) => RoundedCachedImage(url: url)).toList().cast<Widget>() ?? []),
    );
  }


  _subtitle(String name) {
    var capitalized =  name[0].toUpperCase() + name.substring(1);
    var style =  const TextStyle(fontSize: 26, color: Colors.black38);
    return Text(capitalized, style:style );
  }



}


