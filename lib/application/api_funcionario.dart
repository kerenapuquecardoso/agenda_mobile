import 'package:eliane_noivas_mobile/banco/sqlite/dao_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/funcionario.dart';

class ApiFuncionario {
  late Funcionario funcionario;
  late DaoFuncionario dao;

  ApiFuncionario(){
    dao = DaoFuncionario();
    funcionario = Funcionario(dao: dao);
  }

  Future<DtoFuncionario> salvar(DtoFuncionario dto) async{
    return await funcionario.salvar(dto);
  }

  Future<DtoFuncionario> alterar(DtoFuncionario dto) async{
    return await funcionario.alterar(dto);
  }

  Future<DtoFuncionario> buscarPorId(dynamic id) async{
    return await funcionario.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await funcionario.deletarPorId(id);
    return true;
  }

  Future<List<DtoFuncionario>> buscarTodos() async{
    return await funcionario.buscarTodos();
  }


}