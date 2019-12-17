import 'package:flutter/material.dart';
import 'package:sqlpeoyext/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'https') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se pudo abrir pagina ${scan.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
