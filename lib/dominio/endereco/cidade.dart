import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/endereco/estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCidade.dart';
class Cidade {
  dynamic? _id;
  String? _nome;
  dynamic? _estado;
  String _status = 'A';
  IDAOCidade dao;

  Cidade({required this.dao});

  validar({required DtoCidade dto}) {
    nome = dto.nome;
    estado = dto.id_estado;
    status = dto.status; 
  }

  Future<DtoCidade> salvar(DtoCidade dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoCidade> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoCidade>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    this.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoCidade> alterar(DtoCidade dto) async {
    return await dao.alterar(dto);
  }
  
  String? get nome => _nome;
  int? get estado => _estado;
  String get status => _status;

  set id(int? id){
    if(id == null) throw Exception('ID não pode ser nulo');
    if(id < 0) throw Exception('ID não pode ser negativo');
    this.id = id;
  }

  set nome(String? nome){
    if(nome == null) throw Exception('Nome não pode ser nulo.');
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio.');
    this.nome = nome;
  }

  set estado(int? estado){
    if(estado == null) throw Exception('estado não pode ser nulo.');
    this.estado = estado;
  }


  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' || status != 'I') throw Exception('Status deve ser "A" ou "I".');
    this.status = status;
  }


}