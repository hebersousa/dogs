import 'package:dogs/common/widgets/rounded_cached_image.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:dogs/home/screens/breed_detail_page/favorite_button_widget.dart';
import 'package:flutter/material.dart';

class BreedListItem extends StatelessWidget {
  final Breed breed;
  const BreedListItem({Key? key, required  this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(key: Key(breed.name!),
      mainAxisSize: MainAxisSize.max,
      children: [
        _image(),
        _subtitle(breed.name!),
        FavoriteButtonWidget(breed: breed)
      ],
    );
  }


  _image() => breed.coverImage!=null ? SizedBox(width: double.infinity,
      child: RoundedCachedImage(url: breed.coverImage! )) : const LoadingImage();



  _subtitle(String name) {
    var capitalized =  name[0].toUpperCase() + name.substring(1);
    var style =  const TextStyle(fontSize: 26, color: Colors.black38);
    return Text(capitalized, style:style );
  }


}


