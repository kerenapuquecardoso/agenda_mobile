import 'dart:convert';
import 'package:eliane_noivas_mobile/application/api_funcionario.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_funcionario.dart';
import 'package:eliane_noivas_mobile/rotas.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FormFuncionario extends StatefulWidget {
  @override
  _FormFuncionarioState createState() => _FormFuncionarioState();
}

class _FormFuncionarioState extends State<FormFuncionario> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final _statusController = TextEditingController();
   bool _isObscure = true;
   
  void _criarProcedimento() async {
    final nome = _nomeController.text;
    final senha = _senhaController.text;
    final cpf = _cpfController.text;
    final status = _statusController.text;

    DtoFuncionario dto = DtoFuncionario(
      nome: nome,
      CPF: cpf,
      senha: senha,
      status: status,
    );

    ApiFuncionario apiFuncionario = ApiFuncionario();
    await apiFuncionario.salvar(dto);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Funcionário salvo com sucesso!')),
    );
  }


  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _senhaController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void limparCamposPreenchidos() {
    _nomeController.clear();
    _cpfController.clear();
    _senhaController.clear();
    _statusController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Funcionário'),
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
             TextField(
              controller: _senhaController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'senha',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
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
                  Navigator.pushNamed(context, Rotas.listaCliente);
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