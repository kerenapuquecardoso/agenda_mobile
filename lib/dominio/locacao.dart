import 'package:eliane_noivas_mobile/dominio/dto/dto_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOLocacao.dart';

class Locacao{
  dynamic? id;
  dynamic? _cliente_id;
  dynamic? _funcionario_id;
  DateTime? _data_locacao = DateTime.now();
  DateTime? _data_devolucao;
  DateTime? _data_retirada;
  String? _status = 'A';
  double? _valor_total = 0.0;
  List<DtoTrajeLocacao> _trajes = [];
  IDAOLocacao dao;

  Locacao({required this.dao});

  validar({required DtoLocacao dto}){
    _cliente_id = dto.cliente_id;
    _funcionario_id = dto.funcionario_id;
    _data_locacao = dto.data_locacao;
    _data_devolucao = dto.data_devolucao;
    _data_retirada = dto.data_retirada;
    _status = dto.status;
    _valor_total = dto.valor_total;
    _trajes = dto.trajes;
  }

  Future<DtoLocacao> salvar(DtoLocacao dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoLocacao> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoLocacao>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    this.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoLocacao> alterar(DtoLocacao dto) async {
    return await dao.alterar(dto);
  }

  dynamic get cliente_id => _cliente_id;
  dynamic get funcionario_id => _funcionario_id;
  DateTime get data_locacao => _data_locacao!;
  DateTime get data_devolucao => _data_devolucao!;
  DateTime get data_retirada => _data_retirada!;
  String get status => _status!;
  double get valor_total => _valor_total!;
  List<DtoTrajeLocacao> get trajes => _trajes;

  set valor_total(double? valor_total){
    if(valor_total == null) throw Exception('Valor total não pode ser nulo.');
    if(valor_total < 0) throw Exception('Valor total não pode ser negativo.');
    _valor_total = valor_total;
  }

  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' && status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }

  set cliente_id(dynamic? cliente_id){
    if(cliente_id == null) throw Exception('Cliente não pode ser nulo.');
    if(cliente_id < 0) throw Exception('Cliente não pode ser negativo.');
    _cliente_id = cliente_id;
  }

  set funcionario_id(dynamic? funcionario_id){
    if(funcionario_id == null) throw Exception('Funcionário não pode ser nulo.');
    if(funcionario_id < 0) throw Exception('Funcionário não pode ser negativo.');
    _funcionario_id = funcionario_id;
  }

  set data_locacao(DateTime? data_locacao){
    if(data_locacao == null) throw Exception('Data de locação não pode ser nula.');
    if(data_locacao.isAfter(DateTime.now())) throw Exception('Data de locação não pode ser futura.');
    _data_locacao = data_locacao;
  }

  set data_devolucao(DateTime? data_devolucao){
    if(data_devolucao == null) throw Exception('Data de devolução não pode ser nula.');
    if(data_devolucao.isBefore(_data_locacao!)) throw Exception('Data de devolução não pode ser anterior a data de locação.');
    _data_devolucao = data_devolucao;
  }

  set data_retirada(DateTime? data_retirada){
    if(data_retirada == null) throw Exception('Data de retirada não pode ser nula.');
    if(data_retirada.isBefore(_data_locacao!)) throw Exception('Data de retirada não pode ser anterior a data de locação.');
    _data_retirada = data_retirada;
  }

  set trajes(List<DtoTrajeLocacao> trajes){
    if(trajes.isEmpty) throw Exception('Trajes não pode ser vazio.');
    _trajes = trajes;
  }

}




