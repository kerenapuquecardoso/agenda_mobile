import 'cidade.dart';
class Endereco {
  final String rua;
  final int numero;
  final Cidade cidade;

  Endereco({
    required this.rua,
    required this.numero,
    required this.cidade,
  });
}