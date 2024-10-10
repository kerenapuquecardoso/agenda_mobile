

import 'package:eliane_noivas_mobile/banco/sqlite/dao_cidade.dart';
import 'package:eliane_noivas_mobile/banco/sqlite/dao_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/endereco/cidade.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCidade.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';

class ApiCidade{
  late Cidade cidade;
  late IDAOCidade dao;

  ApiCidade(){
    dao = DaoCidade();
    cidade = Cidade(dao: dao);
  }

  Future<DtoCidade> salvar(DtoCidade dto) async{
    return await cidade.salvar(dto);
  }

  Future<DtoCidade> alterar(DtoCidade dto) async{
    return await cidade.alterar(dto);
  }

  Future<DtoCidade> buscarPorId(dynamic id) async{
    return await cidade.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await cidade.deletarPorId(id);
    return true;
  }

  Future<List<DtoCidade>> buscarTodos() async{
    return await cidade.buscarTodos();
  }


}