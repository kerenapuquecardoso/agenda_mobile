import 'package:eliane_noivas_mobile/banco/sqlite/dao_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/locacao.dart';

class ApiTrajeLocacao{
  late Locacao locacao;
  late DaoLocacao dao;

  ApiLocacao(){
    dao = DaoLocacao();
    locacao = Locacao(dao: dao);
  }

  Future<DtoLocacao> salvar(DtoLocacao dto) async{
    return await locacao.salvar(dto);
  }

  Future<DtoLocacao> alterar(DtoLocacao dto) async{
    return await locacao.alterar(dto);
  }

  Future<DtoLocacao> buscarPorId(dynamic id) async{
    return await locacao.buscarPorId(id);
  }

  Future<bool> deletar(dynamic id) async{
    await locacao.deletarPorId(id);
    return true;
  }

  Future<List<DtoLocacao>> buscarTodos() async{
    return await locacao.buscarTodos();
  }
}