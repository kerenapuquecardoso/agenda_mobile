
import 'package:eliane_noivas_mobile/banco/sqlite/dao_estado.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/endereco/estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOEstado.dart';

class ApiEstado{
  late Estado estado;
  late DaoEstado dao;

  ApiEstado(){
    dao = DaoEstado();
    estado = Estado(dao: dao);
  }

  Future<DtoEstado> salvar(DtoEstado dto) async{
    return await estado.salvar(dto);
  }

  Future<DtoEstado> alterar(DtoEstado dto) async{
    return await estado.alterar(dto);
  }

  Future<DtoEstado> buscarPorId(dynamic id) async{
    return await estado.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await estado.deletarPorId(id);
    return true;
  }

  Future<List<DtoEstado>> buscarTodos() async{
    return await estado.buscarTodos();
  }


}