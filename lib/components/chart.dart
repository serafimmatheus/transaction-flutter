import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> transactions;

  const Chart({required this.transactions, super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date.day == weekDay.day;
        bool sameMonth = transactions[i].date.month == weekDay.month;
        bool sameyear = transactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameyear) {
          totalSum += transactions[i].value;
        }
      }

      return {"day": DateFormat.E().format(weekDay)[0], "value": totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: (tr["value"] as double?) ?? 0.0,
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (tr["value"] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}