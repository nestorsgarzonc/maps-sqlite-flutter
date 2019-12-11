import 'package:flutter/material.dart';
import 'package:qrrecognitions_maps/src/models/scan_model.dart';

import 'package:qrrecognitions_maps/src/pages/dirreciones_page.dart';
import 'package:qrrecognitions_maps/src/pages/maps_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrrecognitions_maps/src/providers/db_provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR scanner"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: _page(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
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

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.camera),
      onPressed: _scanQR,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _scanQR() async {
    //https://pub.dev/
    //  https://maps.google.com/local?q=4.637452993777063,-74.08435810101162
    //
/*
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print(futureString);
    */
    setState(() {});
    String futureString = 'https://pub.dev/';
    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      DBProvider.db.nuevoScan(scan);
    }
  }
}
