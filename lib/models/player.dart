import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  int balance;

  @HiveField(3)
  String currentTileId;

  @HiveField(4)
  bool inJail;

  @HiveField(5)
  int turnSkip;

  Player({
    required this.id,
    required this.name,
    this.balance = 3000000,
    this.currentTileId = 'START',
    this.inJail = false,
    this.turnSkip = 0,
  });
}
