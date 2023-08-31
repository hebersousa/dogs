import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

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


  _body()=> Container();
}
