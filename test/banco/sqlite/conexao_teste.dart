

import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    db = await Conexao.abrir();
  });

  test('teste script create database ',() async{
    var listEstado = await db.rawQuery('SELECT * FROM estado');
    var listCidade = await db.rawQuery('SELECT * FROM cidade');
    var listEndereco = await db.rawQuery('SELECT * FROM endereco');
    var listCliente = await db.rawQuery('SELECT * FROM cliente');
    expect(listEstado.length, 2);
    expect(listCidade.length, 2);
    expect(listEndereco.length, 2);
    expect(listCliente.length, 2);
  });

  
}