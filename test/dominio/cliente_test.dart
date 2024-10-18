import 'package:eliane_noivas_mobile/dominio/interface/IDAOCliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/cliente.dart';
import 'package:flutter_test/flutter_test.dart';


class MockDAOCliente implements IDAOCliente {
  @override
  Future<DtoCliente> salvar(DtoCliente dto) async {
    return dto; 
  }

  @override
  Future<DtoCliente> alterar(DtoCliente dto) async {
    return dto; 
  }

  @override
  Future<bool> alterarStatus(dynamic id) async {
    return true; 
  }

  @override
  Future<DtoCliente> buscarPorId(dynamic id) async {
    return DtoCliente(
        id: id,
        nome: 'Nome Teste',
        CPF: '123.456.789-09',
        telefone: '(44) 99999-9999',
        rua: 'Rua Teste',
        numero: 1,
        cidade_id: 1,
        status: 'A');
  }

  @override
  Future<List<DtoCliente>> buscarTodos() async {
    return [DtoCliente(
        id: 1,
        nome: 'Nome Teste',
        CPF: '123.456.789-09',
        telefone: '(44) 99999-9999',
        rua: 'Rua Teste',
        numero: 1,
        cidade_id: 1,
        status: 'A')];
  }
}

void main() {
  group('Testes para a classe Cliente', () {
    late Cliente cliente;
    late MockDAOCliente mockDAOCliente;

    setUp(() {
      mockDAOCliente = MockDAOCliente();
      cliente = Cliente(dao: mockDAOCliente);
    });

    test('Deve validar e salvar um cliente corretamente', () async {
      var dtoCliente = DtoCliente(
        id: 1,
        nome: 'João Silva',
        CPF: '123.456.789-09',
        telefone: '(44) 99999-9999',
        rua: 'Rua Principal',
        numero: 123,
        cidade_id: 1,
        status: 'A',
      );

      var result = await cliente.salvar(dtoCliente);

      expect(result.nome, equals('João Silva'));
      expect(result.CPF, equals('123.456.789-09'));
      expect(result.telefone, equals('(44) 99999-9999'));
    });

    test('Deve lançar exceção se o telefone for inválido', () {
      var dtoCliente = DtoCliente(
        id: 1,
        nome: 'João Silva',
        CPF: '123.456.789-09',
        telefone: '9999-9999', 
        rua: 'Rua Principal',
        numero: 123,
        cidade_id: 1,
        status: 'A',
      );

      expect(() => cliente.validar(dto: dtoCliente), throwsException);
    });


    test('Deve alterar um cliente corretamente', () async {
      var dtoCliente = DtoCliente(
        id: 1,
        nome: 'Maria Oliveira',
        CPF: '987.654.321-00',
        telefone: '(44) 98888-8888',
        rua: 'Rua Secundária',
        numero: 456,
        cidade_id: 2,
        status: 'I',
      );

      var result = await cliente.alterar(dtoCliente);

      expect(result.nome, equals('Maria Oliveira'));
      expect(result.status, equals('I'));
    });

    test('Deve lançar exceção se o status for inválido', () {
      var dtoCliente = DtoCliente(
        id: 1,
        nome: 'Ana Pereira',
        CPF: '123.456.789-09',
        telefone: '(44) 99999-9999',
        rua: 'Rua Nova',
        numero: 321,
        cidade_id: 3,
        status: 'X', 
      );

      expect(() => cliente.validar(dto: dtoCliente), throwsException);
    });

    test('Deve buscar cliente por ID corretamente', () async {
      var result = await cliente.buscarPorId(1);

      expect(result.id, equals(1));
      expect(result.nome, equals('Nome Teste'));
    });

    test('Deve buscar todos os clientes corretamente', () async {
      var result = await cliente.buscarTodos();

      expect(result.length, greaterThan(0));
      expect(result[0].nome, equals('Nome Teste'));
    });
  });
}
