import 'dart:math';
import 'dart:io';
import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/cupertino.dart';
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
  bool _showButton = false;

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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.chart_bar : Icons.pie_chart;
    final actions = <Widget>[
      _getIconButton(
        !_showButton ? iconList : iconChart,
        () {
          setState(() {
            _showButton = !_showButton;
          });
        },
      ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget? appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: Text("Despesas pessoais"),
            backgroundColor: Theme.of(context).primaryColorDark,
            actions: actions,
          ) as PreferredSizeWidget;

    final finalHeight = mediaQuery.size.height -
        (appBar?.preferredSize.height ?? 0) -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            !_showButton
                ? Container(
                    height:
                        _showButton ? finalHeight * 0.90 : finalHeight * 0.4,
                    child: Chart(
                      transactions: _recentsTransaction,
                    ),
                  )
                : Column(children: [
                    Container(
                      height:
                          _showButton ? finalHeight * 0.90 : finalHeight * 0.90,
                      child: TransactionList(_transactions, _deleteTransaction),
                    ),
                  ]),
          ],
        ),
      ),
    );

    return MaterialApp(
      home: Platform.isIOS
          ? CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text('Despesas Pessoais'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
              ),
              child: bodyPage,
            )
          : Scaffold(
              appBar: appBar,
              body: bodyPage,
              floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () => _openTransactionFormModal(context),
                      child: Icon(Icons.add),
                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Text("Mostrar lista"),
//     Switch.adaptive(
//       activeColor: Colors.deepPurple,
//       value: _showButton,
//       onChanged: (value) {
//         setState(() {
//           _showButton = value;
//         });
//       },
//     ),
//   ],
// ),