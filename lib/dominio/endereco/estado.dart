import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOEstado.dart';

class Estado {
  dynamic? _id;
  String? _nome;
  String? _sigla;
  String _status = 'A';
  IDAOEstado dao;

  Estado({required this.dao});

  validar({required DtoEstado dto}) {
      nome = dto.nome;
      sigla = dto.sigla;
      status = dto.status;
  }

  Future<DtoEstado> salvar(DtoEstado dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoEstado> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoEstado>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    this.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoEstado> alterar(DtoEstado dto) async {
    this.id = dto.id;
    return await dao.alterar(dto);
  }

  String? get nome => _nome;
  String? get sigla => _sigla;
  String get status => _status;

  set id(int? id){
    if(id == null) throw Exception('ID não pode ser nulo');
    if(id < 0) throw Exception('ID não pode ser negativo');
    this._id = id;
  }

  set nome(String? nome){
    if(nome == null) throw Exception('Nome não pode ser nulo.');
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio.');
    _nome = nome;
  }

  set sigla(String? sigla){
    if(sigla == null) throw Exception('A sigla não pode ser nulo.');
    if(sigla.isEmpty) throw Exception('A sigla não pode ser vazio.');
    _sigla = sigla;
  }

  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' && status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }
}

