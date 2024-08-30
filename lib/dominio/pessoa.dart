import 'package:eliane_noivas_mobile/dominio/cpf.dart' as validador;
import 'package:eliane_noivas_mobile/dominio/endereco/endereco.dart';

class Pessoa{
  late dynamic? id;
  late String nome;
  late String CPF;
  late Endereco endereco;

  //gerar getter e setter para os atributos
  Pessoa({this.id,required this.nome, required this.endereco, required this.CPF});

}