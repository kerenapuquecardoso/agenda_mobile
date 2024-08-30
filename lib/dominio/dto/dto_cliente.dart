import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_endereco.dart';

class DtoCliente{
  late dynamic? id;
  late String nome;
  late String CPF;
  late dynamic telefone;
  late DtoEndereco endereco;

  DtoCliente({this.id, required this.nome, required this.CPF, required this.telefone,  required this.endereco});
}