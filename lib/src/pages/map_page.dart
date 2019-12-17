import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqlpeoyext/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapController mapController = new MapController();
  String tipoMapa = 'streets';
  int numeroTipoMapa = 0;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "QR Map",
            style: GoogleFonts.roboto(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true, //Boton atras
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(scan.getLatLng(), 15);
              },
            ),
          ],
        ),
        body: Center(
          child: _crearFlutterMap(scan),
        ),
        floatingActionButton: _botonFlotante(context),
      ),
    );
  }

  Widget _botonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          switch (numeroTipoMapa) {
            case 0:
              tipoMapa = 'dark';
              numeroTipoMapa++;
              break;
            case 1:
              tipoMapa = 'light';
              numeroTipoMapa++;
              break;
            case 2:
              tipoMapa = 'outdoors';
              numeroTipoMapa++;
              break;
            case 3:
              tipoMapa = 'satellite';
              numeroTipoMapa++;
              break;
            default:
              tipoMapa = 'streets';
              numeroTipoMapa = 0;
          }
        });
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.radio_button_unchecked),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoibmVzdG9yc2dhcnpvbmMiLCJhIjoiY2s0Mzl4aGNpMDVxYjNmcGN4bDBzdjZqMCJ9.uH-hL_aohmm4bobt21beVg',
          'id': 'mapbox.$tipoMapa'
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 50.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }
}
