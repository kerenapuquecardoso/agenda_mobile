import 'package:eliane_noivas_mobile/banco/sqlite/dao_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:eliane_noivas_mobile/dominio/pessoa.dart';
import 'package:eliane_noivas_mobile/dominio/cpf.dart' as validador;

class Cliente extends Pessoa{
  String? _telefone;
  IDAOCliente dao;
  String? _rua;
  int? _numero;
  dynamic? _cidade;
  String _status = 'A';
 
  Cliente({required this.dao});

  validar({required DtoCliente dto}){
    super.id = dto.id;
    super.nome = dto.nome;
    super.cpf = dto.CPF;
    telefone = dto.telefone; 
    rua = dto.rua;
    status = dto.status; 
    numero = dto.numero;
    cidade = dto.cidade_id;
    validador.CPF(super.cpf!);
  }

  eTelefoneValido(String telefone){
    if(telefone.isEmpty) throw Exception('O nome não pode ser vazio!');
    RegExp regex = RegExp(r'^\(?\d{2}\)?\s?\d{4,5}-?\d{4}$');
    if (!regex.hasMatch(telefone)) throw Exception('O telefone é inválido!');
  }

  Future<DtoCliente> salvar(DtoCliente dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoCliente> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoCliente>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    super.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoCliente> alterar(DtoCliente dto) async {
    return await dao.alterar(dto);
  }

  String? get telefone => _telefone;
  String? get rua => _rua;
  String get status => _status;
  int?  get numero => _numero;
  int?  get cidade => _cidade;



  set telefone(String? telefone){
    if(telefone == null) throw Exception('telefone não pode ser nulo.');
    if(telefone.isEmpty) throw Exception('telefone não pode ser vazio.');
    eTelefoneValido(telefone); 
  _telefone = telefone;
  }

  set rua(String? rua){
    if(rua == null) throw Exception('rua não pode ser nulo.');
    if(rua.isEmpty) throw Exception('rua não pode ser vazio.');
    _rua = rua;
  }

  set numero(int? numero){
    if(numero == null) throw Exception('numero não pode ser nulo.');
    _numero = numero;
  }

  set cidade(int? cidade){
    if(cidade == null) throw Exception('cidade não pode ser nulo.');
    _cidade = cidade;
  }

  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' && status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }
}
