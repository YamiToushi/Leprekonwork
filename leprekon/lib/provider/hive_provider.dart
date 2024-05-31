import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:leprekon/provider/hive_model.dart';

class HiveProvider with ChangeNotifier {
  final Box<Transaction> _transactionBox = Hive.box<Transaction>('transactions');

  void addTransaction(double amount, bool isIncome) {
    final transaction = Transaction(
      amount: amount,
      date: DateTime.now(),
      isIncome: isIncome,
    );
    _transactionBox.add(transaction);
    notifyListeners();
  }

  List<Transaction> get transactions {
    return _transactionBox.values.toList();
  }

  double get totalIncome {
    return _transactionBox.values
        .where((transaction) => transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalOutcome {
    return _transactionBox.values
        .where((transaction) => !transaction.isIncome)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double get totalBalance {
    return totalIncome - totalOutcome;
  }
}
