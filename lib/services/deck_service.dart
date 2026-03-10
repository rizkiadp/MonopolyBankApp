import 'dart:math';

class DeckService {
  final Random _random = Random();
  
  List<String> _chancePile = [];
  List<String> _communityPile = [];
  
  // Define all possible cards here
  final List<String> _allChanceCards = [
    'Denda tilang ngebut Rp1.500.000',
    'Mundur 3 langkah',
    'Perbaiki seluruh properti Anda',
    'Maju ke START (Ambil Rp2.000.000)',
    'Masuk Penjara. Langsung masuk Penjara.',
    'Jalan-jalan ke Stasiun Kereta terdekat',
    'Bank membagikan dividen Rp500.000',
    'Bebas dari Penjara'
  ];

  final List<String> _allCommunityCards = [
    'Biaya dokter. Bayar Rp500.000',
    'Ada kesalahan sistem Bank. Terima Rp2.000.000',
    'Dana liburan cair. Terima Rp1.000.000',
    'Pengembalian pajak. Terima Rp200.000',
    'Asuransi jiwa cair. Terima Rp1.000.000',
    'Bayar tagihan rumah sakit Rp1.000.000',
    'Terima honor konsultasi Rp250.000',
    'Juara 2 lomba keindahan. Ambil Rp100.000'
  ];

  DeckService() {
    _resetChance();
    _resetCommunity();
  }

  void _resetChance() {
    _chancePile = List.from(_allChanceCards);
    _chancePile.shuffle(_random);
  }

  void _resetCommunity() {
    _communityPile = List.from(_allCommunityCards);
    _communityPile.shuffle(_random);
  }

  String drawChance() {
    if (_chancePile.isEmpty) {
      _resetChance();
    }
    return _chancePile.removeLast();
  }

  String drawCommunity() {
    if (_communityPile.isEmpty) {
      _resetCommunity();
    }
    return _communityPile.removeLast();
  }
}
