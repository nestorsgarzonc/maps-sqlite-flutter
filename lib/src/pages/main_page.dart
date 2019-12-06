import 'package:flutter/material.dart';

import 'package:qrrecognitions_maps/src/pages/dirreciones_page.dart';
import 'package:qrrecognitions_maps/src/pages/maps_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
    );
  }

  Widget _page(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return DirreccionesPage();
      default:
        return MapsPage();
    }
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Maps")),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text("Dirrecciones")),
      ],
    );
  }
}
