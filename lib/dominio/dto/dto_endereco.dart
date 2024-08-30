import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';

class DtoEndereco {
  late String rua;
  late int numero;
  late DtoCidade cidade;

  DtoEndereco({required this.rua, required this.numero, required this.cidade});
}