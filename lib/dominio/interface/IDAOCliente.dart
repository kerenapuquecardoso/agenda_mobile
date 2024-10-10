import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';

abstract class IDAOCliente{

  Future<DtoCliente> salvar(DtoCliente dto);
  Future<DtoCliente> buscarPorId(int id);
  Future<List<DtoCliente>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoCliente> alterar(DtoCliente dto);
  

}