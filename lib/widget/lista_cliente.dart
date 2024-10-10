import 'package:eliane_noivas_mobile/application/api_cidade.dart';
import 'package:eliane_noivas_mobile/application/api_cliente.dart';
import 'package:eliane_noivas_mobile/application/api_estado.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cidade.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_cliente.dart';
import 'package:eliane_noivas_mobile/dominio/dto/dto_estado.dart';
import 'package:flutter/material.dart';

class ListaCliente extends StatelessWidget {

  ListaCliente({super.key});

  Future<List<DtoCliente>> buscarTodos() async{
    DtoEstado dtoEstado = DtoEstado(nome: "Mato Grosso", sigla: "MT", status: 'A');
    DtoCidade dtoCidade = DtoCidade(id_estado: dtoEstado.id, nome: "Cruzeiro do Sul", status: 'A');
    DtoCliente dto = DtoCliente(
      nome: "nome",
      CPF: '205.014.260-94',
      telefone: "44999472052",
      rua: "rua",
      numero: 123,
      status: 'A',
      cidade_id: dtoCidade.id
      
    );
    ApiEstado apiEstado = ApiEstado();
    await apiEstado.salvar(dtoEstado);
    ApiCidade apiCidade = ApiCidade();
    await apiCidade.salvar(dtoCidade);
    ApiCliente  apiCliente = ApiCliente();
    DtoCliente dto2 = await apiCliente.salvar(dto);
    print(dto2.nome);
    print("salvou");
 

    return await apiCliente.buscarTodos();
  }
  

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lista dos Clientes'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: FutureBuilder<List<DtoCliente>>(
          future: buscarTodos(),  // Chama o método que busca os clientes
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Exibe um indicador de carregamento
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar os dados: ${snapshot.error}'));  // Captura e exibe erros
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum dado encontrado'));  // Caso não tenha dados
            } else {
              List<DtoCliente> lista = snapshot.data!;  // Dados encontrados
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
      );
  }
}

/**@override
  Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
            TextButton(onPressed: () => Navigator.pushNamed(context, Rotas.detalhesCliente), child: Text('detalhes')),
            TextButton(onPressed: () => Navigator.pushNamed(context, Rotas.formCliente), child: Text('formulário')),
          ],
        ),
    );
  } */


  
