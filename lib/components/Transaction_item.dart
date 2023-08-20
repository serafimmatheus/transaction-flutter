import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_item extends StatelessWidget {
  final Transactions e;
  final void Function(String p1) deleteTransaction;

  const Transaction_item({
    super.key,
    required this.e,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple[800],
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text(
                "R\$ ${e.value}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(e.title),
        subtitle: Text(DateFormat("dd MMMM y").format(e.date)),
        trailing: IconButton(
          onPressed: () => deleteTransaction(e.id),
          icon: Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
