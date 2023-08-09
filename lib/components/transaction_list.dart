import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  void Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: transactions.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text("Nenhuma transação cadastrada."),
                  SizedBox(height: 40),
                  Container(
                      height: 200,
                      child: Image.asset("assets/images/waiting.png",
                          fit: BoxFit.cover)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final e = transactions[index];

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
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
              },
            ),
    );
  }
}
