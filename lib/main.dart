import 'package:dogs/common/services/service_locator.dart';
import 'package:dogs/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:dogs/home/stores/breed_list_store.dart';
import 'package:dogs/home/repositories/breed_repository_remote.dart';




void main()  {
  Hive.initFlutter();
  setupLocator();
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
      home: TabsPage()
    );
  }
}

