import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/endereco/estado.dart';

class DtoCidade{
  dynamic? id;
  String nome;
  dynamic id_estado;
  String status;

  DtoCidade({this.id, required this.id_estado, required this.nome, required this.status});
}