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

    var deleteButton = IconButton(icon: const Icon(Icons.backspace_outlined),
      onPressed: ()=> setState(() {
          txtController.text = '';
          store.filter = '';
        })
      );
    var field =  TextField(onTapOutside: (e)=> FocusScope.of(context).unfocus(),
      controller: txtController,
      decoration:const InputDecoration(
          prefixIcon:  Icon(Icons.search),
          hintText: 'Search a breed',
          border: InputBorder.none
      ),
      onChanged: (valor){
        store.filter = valor;
        setState(() {});

      },
    );

    var textField =  Container(
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.circular(8.0)
      ),
      child:  Row( children: <Widget>[
           Expanded(child:field),
           if(txtController.text.isNotEmpty) deleteButton
          ],
      ),
    );

    return  textField;
  }
}
