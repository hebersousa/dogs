
import 'package:dogs/common/widgets/rounded_cached_image.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/screens/breed_detail_page/favorite_button_widget.dart';
import 'package:dogs/home/states/breed_state.dart';
import 'package:dogs/home/stores/breed_store.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:flutter/foundation.dart';
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
    var bar = AppBar( title: Text(name),centerTitle: true,
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
          return _buildList(state);
        });

  }


  Widget _buildList(BreedState state) {
    if(state is LoadingBreedState) {
      return _loadingWidget();
    }

    if(state is FailureBreedState) {
      return  Center(
          child:  Text(state.message )
      );
    }
    if(state is SuccessBreedState) {
      var images = state.breed.images;

      if(images!.isEmpty) {
        return const Center(child:Text('No Images'));
      }

      return Column(children: [
        FavoriteButtonWidget(breed: state.breed, ),
        Flexible(child: _listView(state!))
      ],);
    }

    return Container();

  }

  _listView(SuccessBreedState state) {
    var images = state.breed.images;

    return ListView.builder(
        itemCount: images!.length,
        itemBuilder: (_, index) {

          final String image = images[index];
          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                child: RoundedCachedImage(url: image),

              )
          );
        }
    );

  }

  _loadingWidget ()=> const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ));

}
