import 'package:eliane_noivas_mobile/banco/sqlite/conexao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOFuncionario.dart';
import 'package:sqflite/sqflite.dart';

class DaoFuncionario implements IDAOFuncionario{
  late Database _db;
  final sqlInserirFuncionario = '''
    INSERT INTO funcionario (funcionario_nome,  cpf, senha, funcionario_status)
    VALUES (?,?,?,?)
  ''';

  final sqlAlterarFuncionario = '''
    UPDATE funcionario funcionario_nome=? cpf=? , senha=?,funcionario_status=?
    WHERE id = ?
  ''';

  final sqlGetByIdFuncionario = '''
    SELECT * FROM funcionario
    WHERE id = ?
  ''';

  final sqlGetAllFuncionario = '''
    SELECT * FROM funcionario
  ''';

  final sqlAterarStatusFuncionario = '''
    UPDATE funcionario SET funcionario_status='I' 
    WHERE id = ?
  ''';

  @override
  Future<DtoFuncionario> alterar(DtoFuncionario dto) async{
     _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAlterarFuncionario, [dto.nome, dto.CPF, dto.senha, dto.status,dto.id]);
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async{
    _db = await Conexao.abrir();
    await _db.rawUpdate(sqlAterarStatusFuncionario, [id]);
    return true;
  }

  @override
  Future<DtoFuncionario> buscarPorId(int id) async{
    _db = await Conexao.abrir();
    var dadosFuncionario = (await _db.rawQuery(sqlGetByIdFuncionario,[id])).first;
    DtoFuncionario funcionario = DtoFuncionario(nome: dadosFuncionario['funcionario_nome'].toString(), senha: dadosFuncionario['senha'].toString(), CPF: dadosFuncionario['cpf'].toString(), status: dadosFuncionario['funcionario_status'].toString());
    return funcionario;
  }

  @override
  Future<List<DtoFuncionario>> buscarTodos() async{
    _db = await Conexao.abrir();
    var dadosFuncionarios = await _db.rawQuery(sqlGetAllFuncionario);
    List<DtoFuncionario> listaFuncionarioS = List.generate(dadosFuncionarios.length, (i){
      var linha = dadosFuncionarios[i];
      return DtoFuncionario(nome: linha['funcionario_nome'].toString(), senha: linha['senha'].toString(), CPF: linha['cpf'].toString(),  status:  linha['estado_status'].toString());
    });
    return listaFuncionarioS;
  }

  @override
  Future<DtoFuncionario> salvar(DtoFuncionario dto) async {
    _db = await Conexao.abrir();
    int id = await _db.rawInsert(sqlInserirFuncionario, [dto.nome, dto.senha, dto.CPF,dto.status]);
    dto.id = id;
    return dto;
  }

}