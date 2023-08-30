import 'package:dogs/home/repositories/breed_repository_remote.dart';
import 'package:dogs/home/screens/breed_detail_page/breed_detail_page.dart';
import 'package:dogs/models/breed.dart';
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

  final BreedListStore store = BreedListStore(BreedRepositoryRemote());

  @override
  Widget build(BuildContext context) {
    var icon = const Icon(Icons.favorite_border, color: Colors.red);
    var bar = AppBar(
        title: const Text("Dog Breeds"),
    actions: [IconButton( onPressed: (){}, icon: icon)],);
    return Scaffold(appBar: bar,
      body: _body(),);
  }


  @override
  void initState() {
    super.initState();
    store.fetchAllBreeds();
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
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                    child: BreedListItem(breed: breed),
                    onTap: ()=> _goDetailPage(breed),
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

  _goDetailPage(Breed breed){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => BreedDetailPage(breed: breed)
    );
  }
}
