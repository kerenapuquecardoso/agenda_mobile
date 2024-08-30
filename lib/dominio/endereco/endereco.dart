import 'cidade.dart';
class Endereco {
  late String rua;
  late int numero;
  late Cidade cidade;

  Endereco({
    required this.rua,
    required this.numero,
    required this.cidade,
  });
}