import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:flutter/material.dart';
import 'package:eliane_noivas_mobile/rotas.dart';

class ListaCliente extends StatelessWidget {

  ListaCliente({super.key});

  Future<List<DtoCliente>> buscarTodos() async{
    ApiCliente apiCliente = ApiCliente();
    return await apiCliente.buscarTodos();
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
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DtoCliente>>(
              future: buscarTodos(),
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
