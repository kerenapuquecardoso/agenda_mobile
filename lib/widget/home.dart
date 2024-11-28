import 'package:eliane_noivas_mobile/rotas.dart';
import 'package:eliane_noivas_mobile/widget/calendario.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliane Noivas'),
        backgroundColor: Color(0xFFdaceba),
      ),
        body: Column(
          children: [
            Calendario(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, Rotas.formCliente),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF5FFC9),
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Cadastrar Clientes',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, Rotas.cadastroTraje),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFc9ffda),
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Cadastrar Traje',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, Rotas.listaCliente),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFc9ecff),
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Listar Clientes',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navegar para a tela de criar contrato
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFf6c9ff),
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Criar Contrato',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}