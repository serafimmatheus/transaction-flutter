import 'dart:math';
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
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transactions(
        id: "1", title: "Kit de Cueca", value: 21.90, date: DateTime.now()),
    Transactions(
        id: "2", title: "Duas Canecas", value: 29.19, date: DateTime.now()),
    Transactions(
        id: "3", title: "Kit Pratos", value: 89.90, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transactions(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Despesas pessoais"),
          backgroundColor: Colors.deepPurple.shade600,
          actions: [
            IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: double.tryParse("100"),
                child: Card(
                  child: Text("Gráfico"),
                  elevation: 5,
                  color: Colors.deepPurple.shade600,
                ),
              ),
              Column(children: [
                TransactionList(_transactions),
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
