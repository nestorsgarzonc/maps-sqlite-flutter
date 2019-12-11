import 'dart:async';

import 'package:qrrecognitions_maps/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener scans base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  agregarScans(ScanModel nuevoScan) async {
    await DBProvider.db.nuevoScan(nuevoScan);
    obtenerScans();
  }

  obtenerScans() async {
    _scansController.add(await DBProvider.db.getTodosScan());
  }

  borrarScans(int id) async {
    await DBProvider.db.deleteScans(id);
    obtenerScans();
  }

  borrarTodosScan() async {
    await DBProvider.db.deleteAllScans();
    obtenerScans();
  }
}
