import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:flutter/material.dart';

class BreedListItem extends StatelessWidget {
  final String name;
  const BreedListItem({Key? key, required  this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name), trailing: _futureImage(),

    );
  }


  _futureImage(){
    return FutureBuilder<String>(
        future: BreedRepositoryRemote().getImage(name),
        builder: (context,shot){
          if(shot.hasData){
            return Image.network(width: 150,fit: BoxFit.cover,
              shot.data.toString(),
              loadingBuilder: (context, child, loadingEvent){
                if (loadingEvent == null) {
                  return child;
                }
                return const Icon(Icons.pets);
              },
             );
          }
          return const Icon(Icons.pets);
        });

  }
}
