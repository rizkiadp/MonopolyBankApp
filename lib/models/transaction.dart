import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 2)
class TransactionLog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fromPlayerName;

  @HiveField(2)
  final String toPlayerName;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final String reason;

  @HiveField(5)
  final DateTime timestamp;

  TransactionLog({
    required this.id,
    required this.fromPlayerName,
    required this.toPlayerName,
    required this.amount,
    required this.reason,
    required this.timestamp,
  });
}
