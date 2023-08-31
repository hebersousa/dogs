import 'package:dogs/favorites/screens/favorites_page.dart';
import 'package:dogs/home/screens/breed_list_page/breed_list_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _index = 0;
  final List<Widget> _screens = [
    const BreedListPage(),
    const FavoritesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: const [
           BottomNavigationBarItem(
             icon:  Icon(Icons.home_filled),
             label: 'Dog Breeds'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites'
          )

        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}