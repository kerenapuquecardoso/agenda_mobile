import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';

abstract class IDAOEstado {
  Future<DtoEstado> salvar(DtoEstado dto);
  Future<DtoEstado> buscarPorId(int id);
  Future<List<DtoEstado>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoEstado> alterar(DtoEstado dto);
}