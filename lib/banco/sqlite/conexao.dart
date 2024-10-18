
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eliane_noivas_mobile/banco/scpript.dart';
class Conexao {
  static late Database _db;
  static Future<Database> abrir() async {

      var path = join(await getDatabasesPath(), 'banco.db');
      _db  = await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
              criarTabelas.forEach(db.execute);
        
            },
      );
    return _db;
  }
}