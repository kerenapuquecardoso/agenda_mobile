import 'package:eliane_noivas_mobile/banco/scpript.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(){
  setUpAll((){ 
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    }
  );

  test('teste script create table',() async{
    var db2 = await openDatabase(inMemoryDatabasePath);
    deleteDatabase(db2.path);
    var db = await openDatabase(inMemoryDatabasePath, version: 1, onCreate: (db, version) {
      criarTabelas.forEach(db.execute);
    });
    //var listEstado = await db.rawQuery('SELECT * FROM estado');
    //var listCidade = await db.rawQuery('SELECT * FROM cidade');
    //var listEndereco = await db.rawQuery('SELECT * FROM endereco');
    var listCliente = await db.rawQuery('SELECT * FROM cliente');
    
    //expect(listEstado.length, 2);
    //expect(listCidade.length, 2);
    //
    //expect(listEndereco.length, 2);
    expect(listCliente.length, 1);

  });

}