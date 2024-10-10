import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeDAOCliente implements IDAOCliente {
  List<DtoCliente> _clientes = [];

  @override
  Future<DtoCliente> salvar(DtoCliente dto) async {
    _clientes.add(dto);
    return dto;
  }

  @override
  Future<DtoCliente> alterar(DtoCliente dto) async {
    final index = _clientes.indexWhere((cliente) => cliente.CPF == dto.CPF);
    if (index != -1) {
      _clientes[index] = dto;
    }
    return dto;
  }

  @override
  Future<DtoCliente> buscarPorId(dynamic id) async {
    return _clientes.firstWhere((cliente) => cliente.CPF == id, orElse: () => throw Exception('Cliente não encontrado'));
  }

  @override
  Future<void> deletarPorId(dynamic id) async {
    _clientes.removeWhere((cliente) => cliente.CPF == id);
  }

  @override
  Future<List<DtoCliente>> buscarTodos() async {
    return _clientes;
  }
  
  @override
  Future<bool> alterarStatus(int id) {
    // TODO: implement alterarStatus
    throw UnimplementedError();
  }
}


void main() {
  late ApiCliente apiCliente;
  late FakeDAOCliente fakeDAOCliente;
  late DtoCliente dtoCliente;

  setUp(() {
    fakeDAOCliente = FakeDAOCliente();
    apiCliente = ApiCliente();
    DtoEstado dtoEstado = DtoEstado(id: 1, nome: "Paraná", sigla: "PR", status: 'A');
    DtoCidade dtoCidade = DtoCidade(id: 1, id_estado: dtoEstado.id, nome: "Cruzeiro do Sul", status: 'A');
    dtoCliente = DtoCliente(
      id: 1,
      nome: "nome",
      CPF: '205.014.260-94',
      telefone: "44999472052",
      rua: "rua",
      numero: 123,
      cidade_id: dtoCidade.id,
      status: 'A'
    );
  });

  group('Testes do ApiCliente com FakeDAO', () {
    test('Salvar cliente', () async {
      final resultado = await apiCliente.salvar(dtoCliente);
      
      expect(resultado, equals(dtoCliente));

      // Verifica se o cliente foi salvo corretamente
      final todos = await apiCliente.buscarTodos();
      expect(todos, contains(dtoCliente));
    });

    test('Alterar cliente', () async {
      await apiCliente.salvar(dtoCliente);
      
      // Modificando o cliente
      dtoCliente.nome = 'nome alterado';
      final resultado = await apiCliente.alterar(dtoCliente);
      
      expect(resultado.nome, equals('nome alterado'));

      // Verifica se a alteração foi aplicada
      final clienteAlterado = await apiCliente.buscarPorId(dtoCliente.CPF);
      expect(clienteAlterado.nome, equals('nome alterado'));
    });

    test('Buscar cliente por ID', () async {
      await apiCliente.salvar(dtoCliente);
      
      final resultado = await apiCliente.buscarPorId(dtoCliente.CPF);
      expect(resultado, equals(dtoCliente));
    });

    test('Deletar cliente', () async {
      await apiCliente.salvar(dtoCliente);
      
      await apiCliente.deletar(dtoCliente.CPF);
      
      final todos = await apiCliente.buscarTodos();
      expect(todos, isEmpty);
    });

    test('Buscar todos os clientes', () async {
      await apiCliente.salvar(dtoCliente);
      
      final todos = await apiCliente.buscarTodos();
      expect(todos, equals([dtoCliente]));
    });
  });
}