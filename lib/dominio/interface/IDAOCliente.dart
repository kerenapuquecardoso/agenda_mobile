import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';

abstract class IDAOCliente{

  DtoCliente salvar(DtoCliente dto);
  DtoCliente buscarPorId(dynamic id);
  List<DtoCliente> buscarTodos();
  DtoCliente deletarPorId(dynamic id);
  DtoCliente alterarPorId(dynamic id, DtoCliente dto);

}