import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:flutter/material.dart';

class FormCliente extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _nomeController = TextEditingController();
    final _telefoneController = TextEditingController();
    final _ruaController = TextEditingController();
    final _cpfController = TextEditingController();
    final _numeroController = TextEditingController();
    final _idCidadeController = TextEditingController();
    final _statusController = TextEditingController();

    Widget createButton(BuildContext context, String route, String label) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, route), 
        child: Text(label));
    }

    void _criarProcedimento() async {
      final nome = _nomeController.text;
      final telefone = _telefoneController.text;
      final rua = _ruaController.text;
      final cpf = _cpfController.text;
      final numero = _numeroController.text;
      final idCidade = _idCidadeController.text;
      final status = _statusController.text;

      DtoCliente dto = DtoCliente(nome: nome, CPF: cpf, telefone: telefone, rua: rua, numero: numero as int, cidade_id: idCidade, status: status);
      ApiCliente apiCliente = ApiCliente();
      await apiCliente.salvar(dto);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente salvo com sucesso!')),
      );
      
    }

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ruaController,
                decoration: InputDecoration(labelText: 'Rua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a rua';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Número inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idCidadeController,
                decoration: InputDecoration(labelText: 'ID da Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o ID da cidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _criarProcedimento,
                child: Text('Salvar'),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
