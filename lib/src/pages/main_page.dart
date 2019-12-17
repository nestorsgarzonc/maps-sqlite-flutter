import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlpeoyext/src/bloc/scans_bloc.dart';
import 'package:sqlpeoyext/src/models/scan_model.dart';
import 'package:sqlpeoyext/src/utils/utils.dart' as utils;

import 'dirreciones_page.dart';
import 'maps_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scansBloc = ScansBloc();
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
            onPressed: () {
              scansBloc.borrarTodosScan();
            },
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
/*
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print(futureString);
    */
    setState(() {});
    //String futureString = 'https://pub.dev/';
    String futureString = 'geo:4.6227143,-74.0817565';
    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScans(scan);
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }
    }
  }
}
