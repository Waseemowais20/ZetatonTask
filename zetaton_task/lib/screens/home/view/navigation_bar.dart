import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/screens/favorites/provider/favorites_provider.dart';
import 'package:zetaton_task/screens/favorites/view/favorites_screen.dart';
import 'package:zetaton_task/screens/home/provider/download_image.dart';
import 'package:zetaton_task/screens/home/provider/home_provider.dart';
import 'package:zetaton_task/screens/home/provider/logout_provider.dart';
import 'package:zetaton_task/screens/home/view/home_screen.dart';
import 'package:zetaton_task/utilites/methods/permission_request.dart';

class AppNavBarPage extends StatefulWidget {
  const AppNavBarPage({Key? key}) : super(key: key);

  @override
  State<AppNavBarPage> createState() => _AppNavBarPageState();
}

class _AppNavBarPageState extends State<AppNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
        ChangeNotifierProvider<FavoritesProvider>(
            create: (context) => FavoritesProvider()),

      ],
      child: const AppNavigationBar(),
    );
  }
}

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  var newIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      newIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
    _pages = <Widget>[
      const HomeScreen(),
      const FavoritesPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                // border: Border(top: BorderSide(color: Colors.grey, width: 1)),
                // color: Colors.green,
                ),
            child: BottomNavigationBar(
              selectedFontSize: 12,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorites",
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          )),
    );
  }
}
