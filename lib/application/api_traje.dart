
import 'package:eliane_noivas_mobile/banco/sqlite/dao_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/traje_locacao.dart';

class ApiTrajeLocacao{
  late TrajeLocacao trajeLocacao;
  late DaoTrajeLocacao dao;

  ApiTrajeLocacao(){
    dao = DaoTrajeLocacao();
    trajeLocacao = TrajeLocacao(dao: dao);
  }

  Future<DtoTrajeLocacao> salvar(DtoTrajeLocacao dto) async{
    return await trajeLocacao.salvar(dto);
  }

  Future<DtoTrajeLocacao> alterar(DtoTrajeLocacao dto) async{
    return await trajeLocacao.alterar(dto);
  }

  Future<DtoTrajeLocacao> buscarPorId(dynamic id) async{
    return await trajeLocacao.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await trajeLocacao.deletarPorId(id);
    return true;
  }

  Future<List<DtoTrajeLocacao>> buscarTodos() async{
    return await trajeLocacao.buscarTodos();
  }
}