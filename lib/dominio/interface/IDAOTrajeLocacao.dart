import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';

abstract class IDAOTrajeLocacao{

  Future<DtoTrajeLocacao> salvar(DtoTrajeLocacao dto);
  Future<DtoTrajeLocacao> buscarPorId(int id);
  Future<List<DtoTrajeLocacao>> buscarTodos();
  Future<bool> alterarStatus(int id);
  Future<DtoTrajeLocacao> alterar(DtoTrajeLocacao dto);
  

}