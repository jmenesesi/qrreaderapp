import 'dart:async';

import 'package:qrreaderapp/bloc/validator.dart';
import 'package:qrreaderapp/providers/db_provider.dart';

class ScansBloc with Validators {

  static final ScansBloc _sigleton = ScansBloc._internal();
  
    factory ScansBloc() {
      return _sigleton;
    } 

    ScansBloc._internal() {
      // Vamos a obtener los scans de la BD
      obtenerScans();
    }

    final _scansController = StreamController<List<ScanModel>>.broadcast();

    Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
    Stream<List<ScanModel>> get scansStreamHTTP => _scansController.stream.transform(validarHttp);

    dispose() {
      _scansController?.close();
    }

  
    obtenerScans() async {
      final scans = await DBProvider.db.getAllScans();
      _scansController.sink.add(scans);
    }

    agregarScan(ScanModel scan) async {
      await DBProvider.db.nuevoScan(scan);
      obtenerScans();
    }

    borrarScan(int id) async {
      await DBProvider.db.deleteScan(id);
      obtenerScans();
    }

    borrarTodos() async {
      await DBProvider.db.deleteAll();
      obtenerScans();
    }
}

//final scanBloc = new ScansBloc();