
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';

abstract class IDAOCidade{
  Future<DtoCidade> salvar(DtoCidade dto);
  Future<DtoCidade> buscarPorId(int id);
  Future<List<DtoCidade>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoCidade> alterar(DtoCidade dto);
}