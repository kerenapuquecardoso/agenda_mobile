import 'package:eliane_noivas_mobile/banco/sqlite/dao_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_endereco.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:flutter_test/flutter_test.dart';

class DAOClienteMock implements DaoCliente{
  Map<int, DtoCliente> databaseMock = {};
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
  Future<DtoCliente> salvar(DtoCliente dto) async{
    if (dto.id == null || dto.id == 0) {
      throw Exception('ID inválido para o cliente.');
    }
    databaseMock[dto.id!] = dto;
    return dto;
  }

 
}


void main() {
  group('Cliente', (){
    var dtoEndereco = DtoEndereco(
        rua: 'Rua ABC',
        numero: 123,
        cidade: DtoCidade(
          nome: 'Cidade XYZ',
          estado: DtoEstado(nome: 'Estado PR', sigla: 'PR'),
      ),
    );

    var dtoCliente = DtoCliente(
      id: 1,
      nome: 'João',
      CPF: '123.456.789-00',
      telefone: '999999999',
      endereco: dtoEndereco,
    );

    var clienteIdInvalido = DtoCliente(
      id: 0,
      nome: 'Maria',
      CPF: '987.654.321-00',
      telefone: '888888888',
      endereco: dtoEndereco,
    );
    
    var dao = DAOClienteMock();

    group('[CA030] - o sistema deverá ser capaz de: criar, atualizar, ler e deletar um cliente.', (){
        test('salvar com id válido', () async {
          expect(await()=> dao.salvar(dtoCliente), returnsNormally);
        });

        test('salvar com id inválido', () async {
          expect(await()=> dao.salvar(clienteIdInvalido), throwsException);
        });

    });

      
  });      
 
   
}