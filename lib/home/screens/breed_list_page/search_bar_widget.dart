import 'package:dogs/common/services/service_locator.dart';
import 'package:dogs/home/stores/breed_list_store.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController txtController = TextEditingController();
  var store = locator<BreedListStore>();

  @override
  Widget build(BuildContext context) {

    var field =  TextField(
      controller: txtController,
      decoration: const InputDecoration(


          hintText: 'Search a breed',
          border: InputBorder.none
      ),
      onChanged: (valor){
        store.filter = valor;


      },
    );

    var textField =  Container(
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:  BorderRadius.circular(8.0)
      ),
      child:  Row(
        children: <Widget>[
           Expanded(
              child:field
          ),

          IconButton(icon: const Icon(Icons.backspace_outlined),
            onPressed: (){
              setState((){
                txtController.text = '';
                store.filter = '';

              });
            },)
        ],
      ),
    );

    return  textField;
  }
}
