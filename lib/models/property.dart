import 'package:hive/hive.dart';

part 'property.g.dart';

enum ColorGroup {
  brown,
  lightBlue,
  pink,
  orange,
  red,
  yellow,
  green,
  blue,
  utility,
}

@HiveType(typeId: 1)
class Property extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final int baseRent;

  @HiveField(4)
  final String colorGroupId; // e.g., 'BROWN', 'UTILITY'

  @HiveField(5)
  int level; // 0 = default, 1 = upgrade 1, 2 = upgrade 2

  @HiveField(6)
  String? ownerId; // null if unowned

  Property({
    required this.id,
    required this.name,
    required this.price,
    required this.baseRent,
    required this.colorGroupId,
    this.level = 0,
    this.ownerId,
  });
}
