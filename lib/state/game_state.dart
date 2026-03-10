import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/property.dart';
import '../models/transaction.dart';
import '../models/scan_result.dart';
import '../services/hive_service.dart';
import '../services/deck_service.dart';
import '../config/game_config.dart';

class GameState extends ChangeNotifier {
  final DeckService deckService = DeckService();

  List<Player> get players => HiveService.playersBox.values.toList();
  List<Property> get properties => HiveService.propertiesBox.values.toList();
  List<TransactionLog> get history =>
      HiveService.transactionsBox.values.toList();

  int currentPlayerIndex = 0;
  Player get currentPlayer => players[currentPlayerIndex];

  DateTime? lastScanTime;

  Future<void> startGame(List<String> playerNames) async {
    await HiveService.setupNewGame(playerNames);
    currentPlayerIndex = 0;
    notifyListeners();
  }

  void nextTurn() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;

    // Jail Logic skip turn
    if (currentPlayer.inJail) {
      if (currentPlayer.turnSkip > 0) {
        currentPlayer.turnSkip--;

        if (currentPlayer.turnSkip == 0) {
          currentPlayer.inJail = false;
        }

        // Move to next player automatically
        currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
      }
    }

    notifyListeners();
  }

  bool _isDebounceActive() {
    if (lastScanTime == null) return false;
    final now = DateTime.now();
    return now.difference(lastScanTime!).inMilliseconds <
        GameConfig.qrDebounceDurationMs;
  }

  ScanResult? handleScan(String qrData) {
    if (_isDebounceActive()) return null;
    lastScanTime = DateTime.now();

    ScanResult? result;

    // Logic to route based on QR Data
    if ((qrData.startsWith('P') && qrData.length <= 2) || (qrData.startsWith('PLAYER_'))) {
      result = ScanResult(ScanType.playerTransfer, payload: qrData.replaceAll('PLAYER_', ''));
    } else if (qrData.startsWith('P') || qrData.startsWith('UTILITY')) {
      result = ScanResult(ScanType.property, payload: qrData);
    } else if (qrData == 'CHANCE') {
      final cardText = deckService.drawChance();
      result = ScanResult(ScanType.chance, payload: cardText);
    } else if (qrData == 'COMMUNITY') {
      final cardText = deckService.drawCommunity();
      result = ScanResult(ScanType.community, payload: cardText);
    } else if (qrData == 'KERETA_RANDOM') {
      result = ScanResult(ScanType.trainRandom);
    } else if (qrData == 'KERETA_FREE') {
      result = ScanResult(ScanType.trainFree);
    } else if (qrData.startsWith('TAX_')) {
      result = ScanResult(ScanType.tax, payload: qrData);
    } else if (qrData == 'START') {
      _addBalance(currentPlayer, GameConfig.startSalary, 'Passed START');
      result = ScanResult(ScanType.unhandled,
          message: 'Passed START! +Rp${GameConfig.startSalary}');
    } else if (qrData == 'JAIL') {
      currentPlayer.inJail = true;
      currentPlayer.turnSkip = 1;
      currentPlayer.save();
      result = ScanResult(ScanType.unhandled, message: 'Go to Jail!');
    } else {
      result = ScanResult(ScanType.unhandled, message: 'Unknown QR: $qrData');
    }

    notifyListeners();
    return result;
  }

  void _addBalance(Player player, int amount, String reason) {
    player.balance += amount;
    player.save();

    // Log transaction
    final tx = TransactionLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fromPlayerName: 'BANK',
        toPlayerName: player.name,
        amount: amount,
        reason: reason,
        timestamp: DateTime.now());
    HiveService.transactionsBox.put(tx.id, tx);
  }

  void _deductBalance(Player player, int amount, String reason) {
    player.balance -= amount;
    player.save();

    final tx = TransactionLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fromPlayerName: player.name,
        toPlayerName: 'BANK',
        amount: amount,
        reason: reason,
        timestamp: DateTime.now());
    HiveService.transactionsBox.put(tx.id, tx);
  }

  void buyProperty(Property property) {
    if (property.ownerId != null) return;
    if (currentPlayer.balance >= property.price) {
      _deductBalance(currentPlayer, property.price, 'Bought \${property.name}');
      property.ownerId = currentPlayer.id;
      property.save();
      notifyListeners();
    }
  }

  void payRent(Property property) {
    if (property.ownerId == null || property.ownerId == currentPlayer.id) {
      return;
    }

    final owner = players.firstWhere((p) => p.id == property.ownerId);

    currentPlayer.balance -= property.baseRent;
    currentPlayer.save();

    owner.balance += property.baseRent;
    owner.save();

    final tx = TransactionLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fromPlayerName: currentPlayer.name,
        toPlayerName: owner.name,
        amount: property.baseRent,
        reason: 'Rent for ${property.name}',
        timestamp: DateTime.now());
    HiveService.transactionsBox.put(tx.id, tx);

    notifyListeners();
  }

  void bankTransaction(int amount, {required bool isReceiving}) {
    if (isReceiving) {
      _addBalance(currentPlayer, amount, 'Received from Bank');
    } else {
      _deductBalance(currentPlayer, amount, 'Paid to Bank');
    }
    notifyListeners();
  }

  void payTax(int amount, String taxName) {
    _deductBalance(currentPlayer, amount, 'Paid Tax: $taxName');
    notifyListeners();
  }

  void transferMoney(Player toPlayer, int amount) {
    if (currentPlayer.balance >= amount) {
      currentPlayer.balance -= amount;
      currentPlayer.save();

      toPlayer.balance += amount;
      toPlayer.save();

      final tx = TransactionLog(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          fromPlayerName: currentPlayer.name,
          toPlayerName: toPlayer.name,
          amount: amount,
          reason: 'Transfer',
          timestamp: DateTime.now());
      HiveService.transactionsBox.put(tx.id, tx);

      notifyListeners();
    }
  }
}
