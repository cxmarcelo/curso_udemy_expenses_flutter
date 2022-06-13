import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          textTheme: theme.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          appBarTheme: theme.appBarTheme.copyWith(
            titleTextStyle: const TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
            ),
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    /*
    Transaction(
      id: "t0",
      title: "Novo Tênis",
      value: 315.00,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: "t1",
      title: "Novo Tênis",
      value: 315.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: "t2",
      title: "Conta de Luz",
      value: 280.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: "t3",
      title: "Gas",
      value: 100.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: "t4",
      title: "Conta #1",
      value: 234.00,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    */
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTranasction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTranasction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                _openTransactionModal(context);
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTransactionModal(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
