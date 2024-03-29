import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
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
  final scansBloc = new ScansBloc();
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
            onPressed: scansBloc.borrarTodosScan,
          )
        ],
      ),
      body: _page(currentIndex),
      bottomNavigationBar: _bottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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

  _scanQR(BuildContext context) async {
    String futureString;
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }
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
