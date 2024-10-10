

import 'package:eliane_noivas_mobile/banco/sqlite/dao_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';

class ApiCliente{
  late Cliente cliente;
  late IDAOCliente dao;

  ApiCliente(){
    dao = DaoCliente();
    cliente = Cliente(dao: dao);
  }

  Future<DtoCliente> salvar(DtoCliente dto) async{
    return await cliente.salvar(dto);
  }

  Future<DtoCliente> alterar(DtoCliente dto) async{
    return await cliente.alterar(dto);
  }

  Future<DtoCliente> buscarPorId(dynamic id) async{
    return await cliente.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await cliente.deletarPorId(id);
    return true;
  }

  Future<List<DtoCliente>> buscarTodos() async{
    return await cliente.buscarTodos();
  }


}