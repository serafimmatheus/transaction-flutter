import 'dart:math';
import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Archivo",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _transactions = [];

  _addTransaction(String title, double value, DateTime data) {
    final newTransaction = Transactions(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: data);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transactions> get _recentsTransaction {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Despesas pessoais"),
      backgroundColor: Theme.of(context).primaryColorDark,
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        )
      ],
    );

    final finalHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: finalHeight * 0.25,
                child: Chart(
                  transactions: _recentsTransaction,
                ),
              ),
              Column(children: [
                Container(
                  height: finalHeight * 0.70,
                  child: TransactionList(_transactions, _deleteTransaction),
                ),
              ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

// import 'package:despesas_pessoais/models/transactions.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';

// import 'components/transaction_form.dart';
// import 'components/transaction_list.dart';

// main() => runApp(const ExpensesApp());

// class ExpensesApp extends StatelessWidget {
//   const ExpensesApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: MyHomePage());
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _transactions = [
//     Transactions(
//       id: 't1',
//       title: 'Novo Tênis de Corrida',
//       value: 310.76,
//       date: DateTime.now(),
//     ),
//     Transactions(
//       id: 't2',
//       title: 'Conta de Luz',
//       value: 211.30,
//       date: DateTime.now(),
//     ),
//   ];

//   _addTransaction(String title, double value) {
//     final newTransaction = Transactions(
//       id: Random().nextDouble().toString(),
//       title: title,
//       value: value,
//       date: DateTime.now(),
//     );

//     setState(() {
//       _transactions.add(newTransaction);
//     });
//   }

//   _openTransactionFormModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return TransactionForm(_addTransaction);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Despesas Pessoais'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => _openTransactionFormModal(context),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(
//               child: Card(
//                 color: Colors.blue,
//                 child: Text('Gráfico'),
//                 elevation: 5,
//               ),
//             ),
//             TransactionList(_transactions),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => _openTransactionFormModal(context),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
