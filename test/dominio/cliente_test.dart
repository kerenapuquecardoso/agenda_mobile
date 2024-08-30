
import 'package:eliane_noivas_mobile/dominio/cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_endereco.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:flutter_test/flutter_test.dart';

class IDAOClienteMock implements IDAOCliente{
  @override
  DtoCliente alterarPorId(id, DtoCliente dto) {
    // TODO: implement alterarPorId
    throw UnimplementedError();
  }

  @override
  DtoCliente buscarPorId(id) {
    // TODO: implement buscarPorId
    throw UnimplementedError();
  }

  @override
  List<DtoCliente> buscarTodos() {
    // TODO: implement buscarTodos
    throw UnimplementedError();
  }

  @override
  DtoCliente deletarPorId(id) {
    // TODO: implement deletarPorId
    throw UnimplementedError();
  }

  @override
  DtoCliente salvar(DtoCliente dto) {
    return dto;
  }
}


void main() {
  group('Cliente', (){
    var dto = DtoCliente(
      telefone: '44999060526',
      CPF: '123.999.029-47',
      id: 1,
      nome: 'Keren',
      endereco: DtoEndereco(
        rua: 'Carlinda',
        numero: 10,
        cidade: DtoCidade(
          nome: 'Cruzeiro do Sul',
          estado: DtoEstado(
            nome: 'Paraná',
            sigla: 'PR',
          ),
        ),
      ),
    );
    var dao = IDAOClienteMock();
    var cliente = Cliente(dao: dao, dto: dto);
    group('Teste de salvar Um cliente', (){
      test('Salvar professor', (){
        expect(() => professor.salvar(dtoCompleto), equals(dtoCompleto.nome));});





  });
}
