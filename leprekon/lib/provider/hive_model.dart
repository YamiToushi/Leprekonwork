import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final bool isIncome;

  Transaction({
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}
