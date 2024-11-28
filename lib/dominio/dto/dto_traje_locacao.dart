class DtoTrajeLocacao{
  dynamic? id;
  String nome;
  String medidas;
  String tipo;
  String cor;
  String? status;
  double? preco;

  DtoTrajeLocacao({
    required this.nome,
    required this.medidas,
    required this.tipo,
    required this.cor,
    required this.preco,
    this.status,
    this.id
  });
}