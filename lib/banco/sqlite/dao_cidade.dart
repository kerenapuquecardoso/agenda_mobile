
import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCidade.dart';
import 'package:sqflite/sqflite.dart';

class DaoCidade implements IDAOCidade{

  late Database _db;
  
  final sqlInsert = '''
    INSERT INTO cidade (nome, estado_id, cidade_status)
    VALUES (?,?,?)
  ''';

  final sqlAlterarCidade = '''
    UPDATE cidade nome=? estado_id=? cidade_status=?
    WHERE id = ?
  ''';

   final sqlGetByIdCidade = '''
    SELECT cidade.*, estado.nome, estado.sigla, estado.estado_status
    FROM cidade
    JOIN estado ON cidade.estado_id = estado.id
    WHERE cidade.id = ?
  ''';

  final sqlGetAllIdCidade = '''
    SELECT cidade.*, estado.nome, estado.sigla, estado.estado_status
    FROM cidade
    JOIN estado ON cidade.estado_id = estado.id
  ''';

  final sqlAterarStatusCidade = '''
    UPDATE cidade SET status='I' 
    WHERE id = ?
  ''';

  
  @override
  Future<DtoCidade> alterar(DtoCidade dto) async{
     _db = await Conexao.abrir();
     await _db.rawUpdate(sqlAlterarCidade, [dto.nome, dto.id_estado, dto.status, dto.id]);
     return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async{
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAterarStatusCidade, [id]);
    return true;
  }

  @override
  Future<DtoCidade> buscarPorId(int id) async{
    _db = await Conexao.abrir();
    var dadosCidade = (await _db.rawQuery(sqlGetByIdCidade, [id])).first;
    DtoEstado estado = DtoEstado(nome: dadosCidade['estado_nome'].toString(), sigla: dadosCidade['sigla'].toString(), status: dadosCidade['estado_status'].toString());
    DtoCidade cidade = DtoCidade(id_estado: estado.id , nome: dadosCidade['cidade_nome'].toString(), status: dadosCidade['cidade_status'].toString());
    return cidade;
  }

  @override
  Future<List<DtoCidade>> buscarTodos() async{
    _db = await Conexao.abrir();
    var dadosCidades = await _db.rawQuery(sqlGetAllIdCidade);
    List<DtoCidade> cidades = List.generate(dadosCidades.length, (i) {
      var linha = dadosCidades[i];
     
      DtoEstado estado = DtoEstado(
        nome: linha['estado_nome'].toString(),
        sigla: linha['sigla'].toString(),
        status: linha['estado_status'].toString(),
      );

      return DtoCidade(
        id_estado: estado.id,
        nome: linha['cidade_nome'].toString(),
        status: linha['cidade_status'].toString(),
      );
    });

    return cidades;
  }

  @override
  Future<DtoCidade> salvar(DtoCidade dto) async{
    _db = await Conexao.abrir();
    await _db.rawInsert(sqlInsert, [dto.nome, dto.status, dto.id_estado]);
    return dto;
  }

}