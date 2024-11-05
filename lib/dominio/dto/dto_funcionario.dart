class DtoFuncionario {
  dynamic? id;
  String nome;
  String CPF;
  String status;
  String? senha;
  
  DtoFuncionario({this.id, required this.nome, required this.CPF, this.senha, required this.status});
}