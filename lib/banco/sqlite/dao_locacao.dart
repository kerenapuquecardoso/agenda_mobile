import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOLocacao.dart';
import 'package:eliane_noivas_mobile/dominio/traje_locacao.dart';
import 'package:sqflite/sqflite.dart';

class DaoLocacao implements IDAOLocacao {
  late Database _db;
  
  final sqlInserirLocacao = '''
    INSERT INTO locacao (cliente_id, funcionario_id, data_locacao, data_devolucao, data_retirada, status, valor_total)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  ''';

  final sqlAlterarLocacao = '''
    UPDATE locacao SET cliente_id=?, funcionario_id=?, data_locacao=?, data_devolucao=?, data_retirada=?, status=?, valor_total=?
    WHERE id = ?
  ''';

  final sqlGetByIdLocacao = '''
    SELECT * FROM locacao
    WHERE id = ?
  ''';

  final sqlGetAllLocacao = '''
    SELECT * FROM locacao
  ''';

  final sqlAlterarStatusLocacao = '''
    UPDATE locacao SET status='I' 
    WHERE id = ?
  ''';

  final sqlGetTrajesByLocacaoId = '''
    SELECT t.* FROM traje t
    INNER JOIN locacao_traje lt ON t.id = lt.traje_id
    WHERE lt.locacao_id = ?
  ''';

  @override
  Future<DtoLocacao> alterar(DtoLocacao dto) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarLocacao, [
      dto.cliente_id,
      dto.funcionario_id,
      dto.data_locacao?.toIso8601String(),
      dto.data_devolucao?.toIso8601String(),
      dto.data_retirada?.toIso8601String(),
      dto.status,
      dto.valor_total,
      dto.id
    ]);
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarStatusLocacao, [id]);
    return true;
  }

  @override
  Future<DtoLocacao> buscarPorId(int id) async {
    _db = await Conexao.abrir();
    var dados = (await _db.rawQuery(sqlGetByIdLocacao, [id])).first;
    var trajes = await _db.rawQuery(sqlGetTrajesByLocacaoId, [id]);
    List<DtoTrajeLocacao> listaTrajes = List.generate(trajes.length, (i) {
      var linha = trajes[i];
      return DtoTrajeLocacao(
        nome: linha['traje_nome'].toString(),
        medidas: linha['medidas'].toString(),
        cor: linha['cor'].toString(),
        tipo: linha['tipo'].toString(),
        preco: (linha['preco'] as num).toDouble(),
        status: linha['traje_status'].toString()
      );
    });
    DtoLocacao locacao = DtoLocacao(
      id: dados['id'],
      cliente_id: dados['cliente_id'],
      funcionario_id: dados['funcionario_id'],
      data_locacao: dados['data_locacao'] != null ? DateTime.parse(dados['data_locacao'] as String) : DateTime.now(),
      data_devolucao: dados['data_devolucao'] != null ? DateTime.parse(dados['data_devolucao'] as String) : null,
      data_retirada: dados['data_retirada'] != null ? DateTime.parse(dados['data_retirada'] as String) : null,
      status: dados['status'].toString(),
      valor_total: dados['valor_total'] != null ? (dados['valor_total'] as num).toDouble() : 0.0,
      trajes: listaTrajes
    );
    return locacao;
  }

  @override
  Future<List<DtoLocacao>> buscarTodos() async {
    _db = await Conexao.abrir();
    var dados = await _db.rawQuery(sqlGetAllLocacao);
    List<DtoLocacao> listaLocacoes = await Future.wait(dados.map((linha) async {
      var trajes = await _db.rawQuery(sqlGetTrajesByLocacaoId, [linha['id']]);
      List<DtoTrajeLocacao> listaTrajes = List.generate(trajes.length, (j) {
        var linhaTraje = trajes[j];
        return DtoTrajeLocacao(
          nome: linhaTraje['traje_nome'].toString(),
          medidas: linhaTraje['medidas'].toString(),
          cor: linhaTraje['cor'].toString(),
          tipo: linhaTraje['tipo'].toString(),
          preco: (linhaTraje['preco'] as num).toDouble(),
          status: linhaTraje['traje_status'].toString()
        );
      });

      return DtoLocacao(
        cliente_id: linha['cliente_id'],
        funcionario_id: linha['funcionario_id'],
        data_locacao: linha['data_locacao'] != null ? DateTime.parse(linha['data_locacao'] as String) : DateTime.now(),
        data_devolucao: linha['data_devolucao'] != null ? DateTime.parse(linha['data_devolucao'] as String) : null,
        data_retirada: linha['data_retirada'] != null ? DateTime.parse(linha['data_retirada'] as String) : null,
        status: linha['status'].toString(),
        valor_total: linha['valor_total'] != null ? (linha['valor_total'] as num).toDouble() : 0.0,
        trajes: listaTrajes
      );
    }).toList());

    return listaLocacoes;
  }

  @override
  Future<DtoLocacao> salvar(DtoLocacao dto) async {
    _db = await Conexao.abrir();
    int id = await _db.rawInsert(sqlInserirLocacao, [
      dto.cliente_id,
      dto.funcionario_id,
      dto.data_locacao?.toIso8601String(),
      dto.data_devolucao?.toIso8601String(),
      dto.data_retirada?.toIso8601String(),
      dto.status,
      dto.valor_total
    ]);
    dto.id = id;

    for (var traje in dto.trajes) {
      await _db.rawInsert(
        'INSERT INTO locacao_traje (locacao_id, traje_id) VALUES (?, ?)',
        [id, traje.id]
      );
    }

    return dto;
  }
}