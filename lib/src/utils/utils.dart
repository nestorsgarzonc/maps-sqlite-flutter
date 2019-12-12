import 'package:sqlpeoyext/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(ScanModel scan) async {
  if (scan.tipo == 'https' || scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se pudo abrir pagina ${scan.valor}';
    }
  }else{
    print("geo");
  }
}
