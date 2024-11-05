import 'package:flutter_test/flutter_test.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/funcionario.dart';
import 'package:eliane_noivas_mobile/banco/sqlite/dao_funcionario.dart';

void main() {
  late DaoFuncionario daoFuncionarioMock;
  late Funcionario funcionario;

  setUp(() {
    daoFuncionarioMock = DaoFuncionario(); // Cria o mock do DAO
    funcionario = Funcionario(dao: daoFuncionarioMock); // Cria o funcionário com o DAO mockado
  });

  test('Salvar um funcionário com dados válidos', () async {
    var dto = DtoFuncionario(
      nome: 'João Silva',
      CPF: '12345678900',
      senha: 'Senha123',
      status: 'A',
    );
    
    final resultado = await funcionario.salvar(dto);
    expect(resultado.nome, 'João Silva');
    expect(resultado.CPF, '12345678900');
    expect(resultado.senha, 'Senha123');
    expect(resultado.status, 'A');
  });

  test('Senha válida', () {
    expect(() => funcionario.senha = 'Senha123', returnsNormally);
  });

  test('Senha inválida sem maiúscula, número ou comprimento mínimo', () {
    expect(() => funcionario.senha = 'senha', throwsException);
    expect(() => funcionario.senha = 'SENHA', throwsException);
    expect(() => funcionario.senha = 'senha123', throwsException);
  });

  test('Status aceita apenas "A" ou "I"', () {
    funcionario.status = 'A';
    expect(funcionario.status, 'A');
    
    funcionario.status = 'I';
    expect(funcionario.status, 'I');
    
    expect(() => funcionario.status = 'X', throwsException);
  });

  test('Buscar funcionário por ID', () async {
    final dto = await funcionario.buscarPorId(1);
    expect(dto.id, 1);
    expect(dto.nome.isNotEmpty, true);
  });

  test('Buscar todos os funcionários', () async {
    final lista = await funcionario.buscarTodos();
    expect(lista.isNotEmpty, true);
  });

  test('Deletar funcionário por ID altera status', () async {
    final resultado = await funcionario.deletarPorId(1);
    expect(resultado, true);
  });
}
