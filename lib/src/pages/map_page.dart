import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqlpeoyext/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan=ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mapa",
            style: GoogleFonts.roboto(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Text(scan.valor),
        ),
      ),
    );
  }
}
