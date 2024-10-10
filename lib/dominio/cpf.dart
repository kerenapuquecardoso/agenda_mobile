class CPF {
  late String numerosCPF;

  CPF(String cpf) {
    eVazio(cpf);
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    numerosCPF = cpf;
    eOnzeNumeros();
    eNumeroDiferente();
  }

  void eVazio(String cpf) {
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio!');
  }

  bool eOnzeNumeros() {
    if (numerosCPF.length != 11) throw Exception('CPF precisa ter 11 números');
    return true;
  }

  bool eNumeroDiferente() {
    if (numerosCPF.split('').toSet().length == 1) {
      throw Exception('CPF não pode ter números iguais');
    }
    return true;
  }

}