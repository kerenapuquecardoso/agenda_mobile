
import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOEstado.dart';
import 'package:sqflite/sqflite.dart';

class DaoEstado implements IDAOEstado{
  late Database _db;
  final sqlInserirEstado = '''
    INSERT INTO estado (estado_nome, sigla, estado_status)
    VALUES (?,?,?)
  ''';

  final sqlAlterarEstado = '''
    UPDATE estado estado_nome=? sigla=? estado_status=?
    WHERE id = ?
  ''';

  final sqlGetByIdEstado = '''
    SELECT * FROM estado
    WHERE id = ?
  ''';

  final sqlGetAllIdEstado = '''
    SELECT * FROM estado
  ''';

  final sqlAterarStatusEstado = '''
    UPDATE estado SET estado_status='I' 
    WHERE id = ?
  ''';


  @override
  Future<DtoEstado> alterar(DtoEstado dto) async {
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAterarStatusEstado, [dto.nome, dto.sigla, dto.status,dto.id]);
    return dto;
  }

  @override
  Future<DtoEstado> buscarPorId(int id) async{
    _db = await Conexao.abrir();
    var dadosEstado = (await _db.rawQuery(sqlGetByIdEstado,[id])).first;
    DtoEstado estado = DtoEstado(nome: dadosEstado['estado_nome'].toString(), sigla: dadosEstado['sigla'].toString(), status: dadosEstado['estado_status'].toString());
    return estado;
  }

  @override
  Future<List<DtoEstado>> buscarTodos() async{
    _db = await Conexao.abrir();
    var dadosEstados = await _db.rawQuery(sqlGetAllIdEstado);
    List<DtoEstado> estados = List.generate(dadosEstados.length, (i){
      var linha = dadosEstados[i];
      return DtoEstado(nome: linha['estado_nome'].toString(), sigla: linha['sigla'].toString(), status:  linha['estado_status'].toString());
    });
    return estados;
  }

  @override
  Future<DtoEstado> salvar(DtoEstado dto) async {
     _db = await Conexao.abrir();
    int id = await _db.rawInsert(sqlInserirEstado, [dto.nome, dto.sigla, dto.status]);
    dto.id = id;
    return dto;
  }
  
  @override
  Future<bool> alterarStatus(int id) async{
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAterarStatusEstado, [id]);
    return true;
  }

}