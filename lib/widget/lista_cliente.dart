import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:flutter/material.dart';
import 'package:eliane_noivas_mobile/rotas.dart';

class ListaCliente extends StatefulWidget {
  ListaCliente({super.key});

  @override
  _ListaClienteState createState() => _ListaClienteState();
}

class _ListaClienteState extends State<ListaCliente> {
  late Future<List<DtoCliente>> futureClientes;

  @override
  void initState() {
    super.initState();
    futureClientes = buscarTodos(); // Chama a função ao iniciar o widget
  }

  Future<List<DtoCliente>> buscarTodos() async {
    ApiCliente apiCliente = ApiCliente();
    return await apiCliente.buscarTodos();
  }

  Future<void> excluirCliente(int id) async {
    ApiCliente apiCliente = ApiCliente();
    await apiCliente.deletar(id);
    atualizarLista();
  }

  Future<void> editarCliente(DtoCliente cliente) async {
    ApiCliente apiCliente = ApiCliente();
    await apiCliente.alterar(cliente);
    atualizarLista();
  }

  void atualizarLista() {
    setState(() {
      futureClientes = buscarTodos(); // Atualiza o Future
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista dos Clientes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Rotas.formCliente);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: atualizarLista, // Botão para atualizar a lista
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DtoCliente>>(
              future: futureClientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar os dados: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum dado encontrado'));
                } else {
                  List<DtoCliente> lista = snapshot.data!;
                  return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      var cliente = lista[index];
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(cliente.nome),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Rotas.formCliente,
                                  arguments: cliente,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await excluirCliente(cliente.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, Rotas.formCliente),
            child: Text('Ir para cadastro'),
          ),
        ],
      ),
    );
  }
}