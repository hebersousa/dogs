import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:dogs/home/stores/breed_store.dart';
import 'package:dogs/models/breed.dart';
import 'package:flutter/material.dart';

class BreedDetailPage extends StatefulWidget {
  final Breed breed;
  const BreedDetailPage({required this.breed, Key? key}) : super(key: key);

  @override
  State<BreedDetailPage> createState() => _BreedDetailPageState();
}

class _BreedDetailPageState extends State<BreedDetailPage> {

  final BreedStore store = BreedStore(BreedRepositoryRemote());


  @override
  void initState() {
    super.initState();
    store.fetchImages(widget.breed);
  }


  @override
  Widget build(BuildContext context) {
    var name = widget.breed.name!.toUpperCase();
    var bar = AppBar(centerTitle: true, title: Text(name),
    );
    return SafeArea(minimum: const EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: bar,
        body: _body(),
      ),
    );
  }

  Widget _body() {

    return ValueListenableBuilder<BreedState>(
        valueListenable: store,
        builder:(context, state, child) {
          return _buildListView(state);
        });

  }


  Widget _buildListView(BreedState state) {
    if(state is LoadingBreedState) {
      return _loadingWidget();
    }

    if(state is FailureBreedState) {
      return const Center(
          child:  Text("Failure")
      );
    }
    if(state is SuccessBreedState){
      var images = state.breed.images;
      return ListView.builder(
          itemCount: images!.length,
          itemBuilder: (_, index) {
            final String image = images[index];
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  child: _image(image),

                )
            );
          }
      );
    }

    return Container();

  }

  _image(String url) {
    return  CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Icon(Icons.pets),
      errorWidget: (context, url, error) => Icon(Icons.pets),
    );
  }

  _loadingWidget ()=> const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ));

}
