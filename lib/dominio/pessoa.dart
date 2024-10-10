
class Pessoa{
  dynamic? id;
  String? nome;
  String? cpf;

  //gerar getter e setter para os atributos
  Pessoa(){
    id = id;
    nome = nome ?? '';
    this.cpf = cpf;
  }
  eNomeNaoVazio(){
    if(nome!.isEmpty) throw Exception('Nome não pode ser vazio');
  }
}