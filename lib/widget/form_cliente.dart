import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';

class FormCliente extends StatefulWidget {
  @override
  _FormClienteState createState() => _FormClienteState();
}

class _FormClienteState extends State<FormCliente> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _ruaController = TextEditingController();
  final _cpfController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cepController = TextEditingController();
  final _statusController = TextEditingController();
  final _cepFocusNode = FocusNode();

  void _criarProcedimento() async {
    final nome = _nomeController.text;
    final telefone = _telefoneController.text;
    final rua = _ruaController.text;
    final cpf = _cpfController.text;
    final numero = int.tryParse(_numeroController.text) ?? 0;
    final idCidade = int.tryParse(_cepController.text);
    final status = _statusController.text;

    DtoCliente dto = DtoCliente(
      nome: nome,
      CPF: cpf,
      telefone: telefone,
      rua: rua,
      numero: numero,
      cidade_id: idCidade,
      status: status,
    );

    ApiCliente apiCliente = ApiCliente();
    await apiCliente.salvar(dto);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cliente salvo com sucesso!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _cepFocusNode.addListener(() {
      if (!_cepFocusNode.hasFocus) {
        verificarCep();
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _ruaController.dispose();
    _cpfController.dispose();
    _numeroController.dispose();
    _cepController.dispose();
    _statusController.dispose();
    _cepFocusNode.dispose();
    super.dispose();
  }

  void limparCamposPreenchidos() {
    _nomeController.clear();
    _telefoneController.clear();
    _ruaController.clear();
    _cpfController.clear();
    _numeroController.clear();
    _cepController.clear();
    _statusController.clear();
  }

  Future<DtoCidade> buscarDadosCidade(int cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var response = await http.get(url, headers: {'Content-Type': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return DtoCidade(
        nome: jsonData['localidade'],
        estado: jsonData['uf'],
        bairro: jsonData['bairro'],
      );
    } else {
      throw Exception('Falha ao buscar cidade: ${response.statusCode}');
    }
  }

  void mostrarPopupConfirmacao(DtoCidade cidade) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmação de Cidade'),
        content: Text('Cidade: ${cidade.nome}\nEstado: ${cidade.estado}\nBairro: ${cidade.bairro}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ok'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Aqui você pode confirmar a ação e prosseguir
    } else {
      _cepController.clear();
    }
  }

  void verificarCep() async {
    print("Verificando CEP...");
    if (_cepController.text.isNotEmpty) {
      try {
        int cep = int.parse(_cepController.text);
        DtoCidade cidade = await buscarDadosCidade(cep);
        mostrarPopupConfirmacao(cidade);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CEP inválido ou erro na busca.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o CPF' : null,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o telefone' : null,
              ),
              TextFormField(
                controller: _ruaController,
                decoration: InputDecoration(labelText: 'Rua'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a rua' : null,
              ),
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o número';
                  return int.tryParse(value) == null ? 'Número inválido' : null;
                },
              ),
              TextFormField(
                controller: _cepController,
                decoration: InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
                focusNode: _cepFocusNode,
                validator: (value) => value == null || value.isEmpty ? 'Informe o CEP da cidade' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o status' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _criarProcedimento();
                    limparCamposPreenchidos();
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}