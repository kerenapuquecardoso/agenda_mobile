
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';

abstract class IDAOFuncionario{

  Future<DtoFuncionario> salvar(DtoFuncionario dto);
  Future<DtoFuncionario> buscarPorId(int id);
  Future<List<DtoFuncionario>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoFuncionario> alterar(DtoFuncionario dto);
  

}