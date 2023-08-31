import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs/common/widgets/rounded_cached_image.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:flutter/material.dart';

class BreedListItem extends StatelessWidget {
  final Breed breed;
  const BreedListItem({Key? key, required  this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   _container();
  }

   _container() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _futureImage(),
        _subtitle(breed.name!)
      ],
    );
  }


  _subtitle(String name) {
    var capitalized =  name[0].toUpperCase() + name.substring(1);
    var style =  const TextStyle(fontSize: 26, color: Colors.black38);
    return Text(capitalized, style:style );
  }



  _futureImage(){
    return FutureBuilder<String>(
        future: BreedRepositoryRemote().getImage(breed),
        builder: (context,shot){
          if(shot.hasData){
            return RoundedCachedImage(url: shot.data.toString());
          }
          return const LoadingImage();
        });
  }

}


