import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOTrajeLocacao.dart';

class TrajeLocacao {
  dynamic? id;
  String? _nome;
  String? _medidas;
  IDAOTrajeLocacao dao;
  String? _tipo;
  String? _cor;
  String? _status = 'A';
  double? _preco = 0.0;

  TrajeLocacao({required this.dao});
  
  

  validar({required DtoTrajeLocacao dto}){
    _nome = dto.nome;
    _medidas = dto.medidas;
    _tipo = dto.tipo;
    _cor = dto.cor;
    _status = dto.status;
    _preco = dto.preco;
  }

   Future<DtoTrajeLocacao> salvar(DtoTrajeLocacao dto) async {
    validar(dto: dto);
    return await dao.salvar(dto);
  }

  Future<DtoTrajeLocacao> buscarPorId(dynamic id) async{
    return await dao.buscarPorId(id);
  }

  Future<List<DtoTrajeLocacao>> buscarTodos() async{
    return await dao.buscarTodos();
  }

  Future<bool> deletarPorId(dynamic id) async{
    this.id = id;
    await dao.alterarStatus(id);
    return true;
  }

  Future<DtoTrajeLocacao> alterar(DtoTrajeLocacao dto) async {
    return await dao.alterar(dto);
  }

  String? get nome => _nome;
  String? get medidas => _medidas;
  String? get tipo => _tipo;
  String? get cor => _cor;
  String? get status => _status;
  double? get preco => _preco;

  set preco(double? preco){
    if(preco == null) throw Exception('Preço não pode ser nulo.');
    if(preco < 0) throw Exception('Preço não pode ser negativo.');
    _preco = preco;
  } 
  
  set nome(String? nome){
    if(nome == null) throw Exception('Nome não pode ser nulo.');
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio.');
    _nome = nome;
  }

  set medidas(String? medidas){
    if(medidas == null) throw Exception('Medidas não pode ser nulo.');
    if(medidas.isEmpty) throw Exception('Medidas não pode ser vazio.');
    _medidas = medidas;
  }

  set tipo(String? tipo){
    if(tipo == null) throw Exception('Tipo não pode ser nulo.');
    if(tipo != 'FESTA' && tipo != 'NOIVA' && tipo != 'DAMINHA' && tipo != 'DEBUTANTE' && tipo != 'PAJEM' && tipo != 'NOIVO' && tipo != 'PADRINHO') throw Exception('Status deve ser umas das categorias de traje.');
    _tipo = tipo;
  }

  set cor(String? cor){
    if(cor == null) throw Exception('Cor não pode ser nulo.');
    if(cor.isEmpty) throw Exception('Cor não pode ser vazio.');
    _cor = cor;
  }

  set status(String? status){
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' && status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }
}