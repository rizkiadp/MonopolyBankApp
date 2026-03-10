import 'package:hive_flutter/hive_flutter.dart';
import '../models/player.dart';
import '../models/property.dart';
import '../models/transaction.dart';
import 'board_data.dart';

class HiveService {
  static const String _playersBox = 'players';
  static const String _propertiesBox = 'properties';
  static const String _transactionsBox = 'transactions';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(PlayerAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(PropertyAdapter());
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TransactionLogAdapter());
    }

    // Open Boxes
    await Hive.openBox<Player>(_playersBox);
    await Hive.openBox<Property>(_propertiesBox);
    await Hive.openBox<TransactionLog>(_transactionsBox);
  }

  static Box<Player> get playersBox => Hive.box<Player>(_playersBox);
  static Box<Property> get propertiesBox => Hive.box<Property>(_propertiesBox);
  static Box<TransactionLog> get transactionsBox =>
      Hive.box<TransactionLog>(_transactionsBox);

  static Future<void> setupNewGame(List<String> playerNames) async {
    // Clear existing data
    await playersBox.clear();
    await propertiesBox.clear();
    await transactionsBox.clear();

    // Setup Players
    for (int i = 0; i < playerNames.length; i++) {
      final player = Player(id: 'P\${i+1}', name: playerNames[i]);
      await playersBox.put(player.id, player);
    }

    // Setup Properties
    for (var prop in BoardData.initialProperties) {
      await propertiesBox.put(prop.id, prop);
    }
  }
}
