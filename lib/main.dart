import 'package:dogs/api/my_http_client.dart';
import 'package:dogs/home/breed_ds.dart';
import 'package:dogs/home/screens/breed_list_page.dart';
import 'package:dogs/home/stores/breed_store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dogs',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Dogs'),
      home: BreedListPage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(child: Text("Dogs")),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        BreedDataSource ds = BreedDataSource();
        try {
                BreedStore().fetchAllBreeds();

        } catch(e) {
          print(e);
        }
      }),
    );
  }
}
