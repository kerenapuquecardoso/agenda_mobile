import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';

class DtoCliente{
  dynamic? id;
  String nome;
  String CPF;
  String telefone;
  String rua;
  int numero;
  dynamic cidade_id;
  String status;

  DtoCliente({this.id, required this.nome, required this.CPF, required this.telefone,  required this.rua, required this.numero, required this.cidade_id, required this.status});
}