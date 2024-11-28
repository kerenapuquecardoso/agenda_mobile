import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOTrajeLocacao.dart';
import 'package:sqflite/sqflite.dart';

class DaoTrajeLocacao implements IDAOTrajeLocacao{
  late Database _db;
  final sqlInserirFuncionario = '''
    INSERT INTO traje (traje_nome,  medidas, tipo, cor, preco, traje_status)
    VALUES (?,?,?,?)
  ''';

  final sqlAlterarFuncionario = '''
    UPDATE traje traje_nome=? medidas=? , tipo=?, preco=?, cor=?, traje_status=?
    WHERE id = ?
  ''';

  final sqlGetByIdFuncionario = '''
    SELECT * FROM traje
    WHERE id = ?
  ''';

  final sqlGetAllFuncionario = '''
    SELECT * FROM traje
  ''';

  final sqlAterarStatusFuncionario = '''
    UPDATE traje SET traje_status='I' 
    WHERE id = ?
  ''';

  @override
  Future<DtoTrajeLocacao> alterar(DtoTrajeLocacao dto) async{
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarFuncionario, [dto.nome, dto.medidas, dto.cor, dto.tipo, dto.status,dto.id, dto.preco]);
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async{
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAterarStatusFuncionario, [id]);
    return true;
  }

  @override
  Future<DtoTrajeLocacao> buscarPorId(int id) async{
    _db = await Conexao.abrir();
    var dados = (await _db.rawQuery(sqlGetByIdFuncionario,[id])).first;
    DtoTrajeLocacao funcionario = DtoTrajeLocacao(nome: dados['traje_nome'].toString(), medidas: dados['medidas'].toString(), cor: dados['cor'].toString(), tipo: dados['tipo'].toString(), status: dados['traje_status'].toString(), preco: dados['preco'] != null ? (dados['preco'] as num).toDouble() : 0.0); 
    return funcionario;
  }

  @override
  Future<List<DtoTrajeLocacao>> buscarTodos() async{
    _db = await Conexao.abrir();
    var dados = await _db.rawQuery(sqlGetAllFuncionario);
    List<DtoTrajeLocacao> listaFuncionarioS = List.generate(dados.length, (i){
      var linha = dados[i];
      return DtoTrajeLocacao(nome: linha['traje_nome'].toString(), medidas: linha['medidas'].toString(), cor: linha['cor'].toString(), tipo: linha['tipo'].toString(), status: linha['traje_status'].toString(), preco: linha['preco'] != null ? (linha['preco'] as num).toDouble() : 0.0);
    });
    return listaFuncionarioS;
  }

  @override
  Future<DtoTrajeLocacao> salvar(DtoTrajeLocacao dto) async {
    _db = await Conexao.abrir();
    int id = await _db.rawInsert(sqlInserirFuncionario, [dto.nome, dto.cor, dto.medidas, dto.tipo,dto.status]);
    dto.id = id;
    return dto;
  }

}