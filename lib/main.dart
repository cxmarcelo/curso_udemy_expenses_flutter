import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _transactions = [
    Transaction(id: "t1", title: "Novo Tênis", value: 315.00, date: DateTime.now()),
    Transaction(id: "t2", title: "Conta de Luz", value: 280.00, date: DateTime.now()),
    Transaction(id: "t3", title: "Gas", value: 100.00, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text("Gráfico"),
            ),
          ),
          Card(
            child: Text("Lista de Transações"),
          )
        ],
      ),
    );
  }
}
