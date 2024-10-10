
import 'dart:ffi';

import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:sqflite/sqflite.dart';

class DaoCliente implements IDAOCliente{

  late Database _db;

  final sqlInsert = '''
    INSERT INTO cliente (cliente_nome, cpf, telefone, rua, numero, cliente_status, cidade_id)
    VALUES (?,?,?,?,?,?,?)
  ''';

  final sqlUpdate = '''
    UPDATE cliente SET cliente_nome=?, cpf=?, telefone=?, rua=? , numero=? , cliente_status=?,  cidade_id=?
    WHERE id = ?
  ''';
  final sqlUpdateStatus = '''
    UPDATE cliente SET cliente_status = ?
    WHERE id = ?
  ''';

  final sqlGetById = '''
    SELECT cliente.*, cidade.*, estado.* 
    FROM cliente 
    JOIN cidade ON cliente.cidade_id = cidade.id
    JOIN estado ON cidade.estado_id = estado.id
    WHERE cliente.id = ?
  ''';

  final sqlGetAll = '''
    SELECT cliente.*, cidade.*, estado.* 
    FROM cliente 
    JOIN cidade ON cliente.cidade_id = cidade.id
    JOIN estado ON cidade.estado_id = estado.id
  ''';
 

  @override
  Future<DtoCliente> salvar(DtoCliente dto) async {
    _db = await Conexao.abrir();
    int id  = await _db.rawInsert(sqlInsert, [dto.nome, dto.CPF, dto.telefone, dto.rua, dto.numero, dto.status, dto.cidade_id]);
    dto.id = id;
    return dto;
  }

  
  @override
  Future<DtoCliente> buscarPorId(int id) async{
    _db = await Conexao.abrir();
    var dadosCliente = (await _db.rawQuery(sqlGetById,[id])).first;
    DtoEstado estado = DtoEstado(nome: dadosCliente['estado_nome'].toString(), sigla: dadosCliente['sigla'].toString(), status: dadosCliente['estado_status'].toString());
    DtoCidade cidade = DtoCidade(id_estado: estado.id , nome: dadosCliente['cidade_nome'].toString(), status: dadosCliente['cidade_status'].toString());
    DtoCliente cliente = DtoCliente(
      nome: dadosCliente['cliente_nome'].toString(), 
      CPF: dadosCliente['cpf'].toString(), 
      telefone:  dadosCliente['telefone'].toString(),
      rua: dadosCliente['rua'].toString(), 
      numero: int.parse(dadosCliente['numero'].toString()),
      status: dadosCliente['cliente_status'].toString(), 
      cidade_id: cidade.id, 
      
    );

    return cliente;
  }
  
  @override
  Future<List<DtoCliente>> buscarTodos() async {
    _db = await Conexao.abrir();
    var listaClientes = await _db.rawQuery(sqlGetAll);
    List<DtoCliente>  clientes =  List.generate(listaClientes.length, (i) {
      var linha = listaClientes[i];
      DtoEstado estado = DtoEstado(
        nome: linha['estado_nome'].toString(),
        sigla: linha['sigla'].toString(),
        status: linha['estado_status'].toString(),
      );

      DtoCidade cidade = DtoCidade(
        id_estado: estado.id,
        nome: linha['cidade_nome'].toString(),
        status: linha['cidade_status'].toString(),
      );

      DtoCliente cliente = DtoCliente(
        nome: linha['cliente_nome'].toString(),
        CPF: linha['cpf'].toString(),
        telefone: linha['telefone'].toString(),
        rua: linha['rua'].toString(),
        numero: int.parse(linha['numero'].toString()),
        cidade_id: cidade.id,
        status: linha['cliente_status'].toString(),
      );
      return cliente;
    });
    return clientes;
  }
  
  
  @override
  Future<bool> alterarStatus(int id) async{
   _db = await Conexao.abrir();
    await _db.rawUpdate(sqlUpdateStatus, [id]);
    return true;
  }
  
  @override
  Future<DtoCliente> alterar(DtoCliente dto) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlUpdate, [dto.nome, dto.CPF, dto.cidade_id, dto.numero, dto.rua, dto.status, dto.id]);
    return dto;
  }

}