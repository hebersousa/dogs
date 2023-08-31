import 'package:dogs/common/models/breed.dart';
import 'package:dogs/common/services/local_data_service.dart';
import 'package:dogs/favorites/screens/favorite_item.dart';
import 'package:dogs/favorites/states/favorite_state.dart';
import 'package:dogs/favorites/stores/favorite_store.dart';
import 'package:dogs/home/screens/breed_detail_page/breed_detail_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteStore store = FavoriteStore(LocalDataService());


  @override
  Widget build(BuildContext context) {

    var bar = AppBar(centerTitle: true, title: const Text('Favorites'),
    );
    return SafeArea(minimum: const EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: bar,
        body: _body(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    store.fetchAll();
  }


  Widget errorDialog({required double size, required String message}){
    return SizedBox(
      height: 180,
      width: 200,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed:  ()  {
                setState(() {
                  store.fetchAll();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
        ],
      ),
    );
  }

  @override

  Widget _body() {

    return ValueListenableBuilder<FavoriteState>(
        valueListenable: store,
        builder:(context, state, child) {
          return buildListView(state);
        });
  }


  Widget buildListView(FavoriteState state) {
    if(state is LoadingFavoriteState) {
      return _loadingWidget();
    }

    if(state is FailureFavoriteState) {
      return Center(
          child: errorDialog(size: 20,message: state.message)
      );
    }

    if(state is SuccessFavoriteState){

      if(state.breeds.isEmpty){
        var style =  const TextStyle(fontSize: 26, color: Colors.black38);
        return  Center(child: Text('Empty',style: style));
      }

      return ListView.builder(
          itemCount: state.breeds.length,
          itemBuilder: (_, index) {
            final Breed breed = state.breeds[index];
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  child: FavoriteItem(breed: breed, onPressed: ()=>store.check(breed),),
                  onTap: ()=> _goToDetailPage(breed),
                )
            );
          }
      );
    }

    return Container();

  }

  _loadingWidget ()=> const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ));

  _goToDetailPage(Breed breed){
    
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => BreedDetailPage(breed: breed)
    ).whenComplete(() => store.fetchAll());
  }


}
