import 'package:eliane_noivas_mobile/banco/sqlite/dao_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/pessoa.dart';
import 'package:eliane_noivas_mobile/dominio/cpf.dart' as validador;
class Funcionario extends Pessoa{
  
  String? _senha;
  DaoFuncionario dao;
  String _status = 'A';

  Funcionario({required this.dao});

  validar({required DtoFuncionario dto}){
    super.id = dto.id;
    super.nome = dto.nome;
    super.cpf = dto.CPF;
    this.senha = dto.senha;
    this.status = dto.status;
    validador.CPF(super.cpf!);
  }

   Future<DtoFuncionario> salvar(DtoFuncionario dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoFuncionario> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoFuncionario>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    super.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoFuncionario> alterar(DtoFuncionario dto) async {
    return await dao.alterar(dto);
  }

  String get status => _status;
  String? get senha => _senha;

  set senha(String? senha){
    if(senha == null) throw Exception('senha não pode ser nulo.');
    if(senha.isEmpty) throw Exception('senha não pode ser vazio.');
    eSenhaValida(senha); 
    _senha = senha;
  }
  
  void eSenhaValida(String senha) {
    if(senha.isEmpty) throw Exception('a senha não pode ser vazia!');
    RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
    if (!regex.hasMatch(senha)) throw Exception('a senha é inválida, pois deve conter no mínimo: 6 caractere, 1 numero, 1 letra maipuscula, 1 letra minúscula!');
  }

   set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' && status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }


}



