import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eliane_noivas_mobile/banco/scpript.dart';

class Conexao {
  static late Database _db;

  static Future<Database> abrir({bool resetDatabase = false}) async {
    var path = join(await getDatabasesPath(), 'banco.db');

    // Verifica se o banco deve ser excluído
    if (resetDatabase) {
      await deleteDatabase(path);
    }

    // Abre o banco (ou recria se necessário)
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        criarTabelas.forEach(db.execute);
        inserirDados.forEach(db.execute);
      },
    );

    return _db;
  }
}