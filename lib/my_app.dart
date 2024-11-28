import 'package:eliane_noivas_mobile/rotas.dart';
import 'package:eliane_noivas_mobile/widget/cadastro_funcionario.dart';
import 'package:eliane_noivas_mobile/widget/cadastro_traje.dart';
import 'package:eliane_noivas_mobile/widget/form_cliente.dart';
import 'package:eliane_noivas_mobile/widget/home.dart';
import 'package:eliane_noivas_mobile/widget/lista_cliente.dart';
import 'package:eliane_noivas_mobile/widget/detalhes_cliente.dart';
import 'package:eliane_noivas_mobile/widget/login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Gestão de aluguel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      routes: {
        Rotas.home: (context) => LoginPage(),
        Rotas.formCliente : (context) => FormCliente(),
        Rotas.detalhesCliente : (context) => DetalhesCliente(),
        Rotas.listaCliente : (context) => ListaCliente(),
        Rotas.cadastroFuncionario : (context) => FormFuncionario(),
        Rotas.homePage : (context) => HomeScreen(),
        Rotas.cadastroTraje : (context) => CadastroTraje(),
      }

    );
  }

}