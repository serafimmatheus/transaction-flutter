import 'package:despesas_pessoais/components/Transaction_item.dart';
import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  void Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Text("Nenhuma transação cadastrada."),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Container(
                      height: constraints.maxHeight * 0.70,
                      child: Image.asset("assets/images/waiting.png",
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final e = transactions[index];
              return Transaction_item(
                  e: e, deleteTransaction: deleteTransaction);
            },
          );
  }
}
