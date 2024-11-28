import 'package:eliane_noivas_mobile/dominio/dto/dto_locacao.dart';

abstract class IDAOLocacao {
  Future<DtoLocacao> salvar(DtoLocacao dto);
  Future<DtoLocacao> buscarPorId(int id);
  Future<List<DtoLocacao>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoLocacao> alterar(DtoLocacao dto);
  
}
