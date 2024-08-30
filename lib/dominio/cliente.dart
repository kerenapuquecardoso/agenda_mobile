import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/endereco/endereco.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:eliane_noivas_mobile/dominio/pessoa.dart';

class Cliente extends Pessoa{
  late dynamic telefone;
  late IDAOCliente dao;
  late DtoCliente dto;
  Cliente({required this.dao, required this.dto,  required super.nome, required super.endereco, required super.CPF, super.id}){
    id = dto.id;
    CPF = dto.CPF;
    endereco = dto.endereco as Endereco;
    telefone = dto.telefone;
    nome = dto.nome; 

  }

  DtoCliente salvar(DtoCliente dto){
    return dao.salvar(dto);
  }

}