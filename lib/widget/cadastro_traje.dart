import 'package:eliane_noivas_mobile/application/api_traje.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:flutter/material.dart';

class CadastroTraje extends StatefulWidget {
  @override
  _CadastroTrajeState createState() => _CadastroTrajeState();
}

class _CadastroTrajeState extends State<CadastroTraje> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _medidasController = TextEditingController();
  final _precoController = TextEditingController();
  final _corController = TextEditingController();
  final _statusController = TextEditingController();

  String? _tipoSelecionado;
  final List<String> _tipos = ['FESTA', 'NOIVA', 'DAMINHA', 'DEBUTANTE', 'PAJEM', 'NOIVO', 'PADRINHO'];

  void _criarProcedimento() async {
    final nome = _nomeController.text;
    final medidas = _medidasController.text;
    final tipo = _tipoSelecionado ?? '';
    final cor = _corController.text;
    final preco = double.tryParse(_precoController.text) ?? 0.0;
    final status = _statusController.text;

    DtoTrajeLocacao dto = DtoTrajeLocacao(
      nome: nome,
      tipo: tipo,
      medidas: medidas,
      preco: preco,
      cor: cor,
      status: status,
    );

    ApiTrajeLocacao apiTrajeLocacao = ApiTrajeLocacao();
    await apiTrajeLocacao.salvar(dto);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Traje salvo com sucesso!')),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _medidasController.dispose();
    _precoController.dispose();
    _corController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void limparCamposPreenchidos() {
    _nomeController.clear();
    _medidasController.clear();
    _precoController.clear();
    _corController.clear();
    _statusController.clear();
    setState(() {
      _tipoSelecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Traje'),
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
              DropdownButtonFormField<String>(
                value: _tipoSelecionado,
                decoration: InputDecoration(labelText: 'Tipo'),
                items: _tipos.map((String tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoSelecionado = newValue;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Informe o tipo' : null,
              ),
              TextFormField(
                controller: _medidasController,
                decoration: InputDecoration(labelText: 'Medidas'),
                validator: (value) => value == null || value.isEmpty ? 'Informe as medidas' : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o Valor';
                  return double.tryParse(value) == null ? 'Valor inválido' : null;
                },
              ),
              TextFormField(
                controller: _corController,
                decoration: InputDecoration(labelText: 'Cor'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a cor' : null,
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