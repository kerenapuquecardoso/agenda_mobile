import 'package:eliane_noivas_mobile/dominio/endereco/endereco.dart';
import 'package:eliane_noivas_mobile/dominio/cpf.dart' as validador;

class Cliente {
  late dynamic id;
  late String nome;
  late String CPF;
  final Endereco endereco;

   Cliente({this.id,required this.nome,required this.CPF ,required this.endereco});
  
}