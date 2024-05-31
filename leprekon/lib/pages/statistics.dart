import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:leprekon/provider/hive_provider.dart';
import 'package:leprekon/provider/hive_model.dart';
import 'package:intl/intl.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveProvider>(
      builder: (context, hiveProvider, child) {
        List<Transaction> transactions = hiveProvider.transactions;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  color:
                      transaction.isIncome ? Colors.green[50] : Colors.red[50],
                  child: ListTile(
                    title: Text(
                      '\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction.isIncome ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(transaction.date),
                    ),
                    trailing: Icon(
                      transaction.isIncome
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction.isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
