import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';


export 'package:qrreaderapp/models/scan_model.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, "ScanDB.db" );

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY, '
            'tipo TEXT, '
            'valor TEXT'
            ')'
          );
        }
      );
  }

  // Crear registros
  nuevoScanRow(ScanModel scan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES (${scan.id}, '${scan.tipo}', '${scan.valor}')"
    );
    return res;
  }

  nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert("Scans", scan.toJson());
    return res;
  }

  getScanById( int id) async {
    final db = await database;
    final res = await db.query("Scans", where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    List<ScanModel> scans = List();
    final db = await database;
    final res = await db.query("Scans");
    scans = res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];

    return scans;
  }

  getScansByType(String tipo) async {
    List<ScanModel> scans = List();
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");
    scans = res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return scans;
  }

  // Actualizar registro;
  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = db.update("Scans", scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = db.delete("Scans", where: 'id = ?', whereArgs: [id]) ;
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = db.delete("Scans") ;
    return res;
  }
}