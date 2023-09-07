import 'package:dogs/common/services/service_locator.dart';
import 'package:dogs/common/widgets/rounded_cached_image.dart';
import 'package:dogs/favorites/screens/favorites_page.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/screens/breed_detail_page/breed_detail_page.dart';
import 'package:dogs/common/models/breed.dart';
import 'package:dogs/home/screens/breed_list_page/breed_list_item.dart';
import 'package:dogs/home/states/breed_list_state.dart';
import 'package:dogs/home/stores/breed_list_store.dart';
import 'package:flutter/material.dart';


class BreedListPage extends StatefulWidget {
  const BreedListPage({Key? key}) : super(key: key);

  @override
  State<BreedListPage> createState() => _BreedListPageState();
}

class _BreedListPageState extends State<BreedListPage> {

  final  store = locator<BreedListStore>();

  @override
  Widget build(BuildContext context) {

    var bar = AppBar(
        centerTitle: true,
        title: const Text("Dog Breeds",style: TextStyle(color: Colors.indigo),),
    );
    return Scaffold(appBar: bar,
      body: _body(),);
  }


  @override
  void initState() {
    super.initState();
    store.fetchAllBreeds();
  }


  Widget errorDialog({required double size, required String message}){
    var textStyle = TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: Colors.black
    );
    return SizedBox(
      height: 180,
      width: 200,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
            style: textStyle,
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed:  ()  {
                setState(() {
                  store.fetchAllBreeds();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
        ],
      ),
    );
  }

  @override

  Widget _body() {

    return ValueListenableBuilder<BreedListState>(
        valueListenable: store,
        builder:(context, state, child) {
          return buildListView(state);
        });
  }


  Widget buildListView(BreedListState state) {
    if(state is LoadingBreedListState) {
      return _loadingWidget();
    }

    if(state is FailureBreedListState) {
      return Center(
          child: errorDialog(size: 20,message: state.message)
      );
    }
    if(state is SuccessBreedListState){
      return ListView.builder(
          itemCount: state.breeds.length,
          itemBuilder: (_, index) {

            final Breed breed = state.breeds[index];

            if(breed.coverImage==null){
              store.loadCoverImage(index);
            }
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                    child: BreedListItem(key: Key(breed.name!), breed: breed),
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
    );
  }

}
