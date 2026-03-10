import 'dart:io';

void main() {
  // Update board_data.dart to multiply values by 10000
  var boardFile = File('lib/services/board_data.dart');
  var lines = boardFile.readAsLinesSync();
  var newLines = <String>[];
  for (var line in lines) {
    var priceMatch = RegExp(r'price:\s*(\d+)').firstMatch(line);
    if (priceMatch != null) {
      var val = int.parse(priceMatch.group(1)!);
      line = line.replaceFirst('price: $val', 'price: ${val * 10000}');
    }
    var rentMatch = RegExp(r'baseRent:\s*(\d+)').firstMatch(line);
    if (rentMatch != null) {
      var val = int.parse(rentMatch.group(1)!);
      if (val > 0) {
        line = line.replaceFirst('baseRent: $val', 'baseRent: ${val * 10000}');
      }
    }
    newLines.add(line);
  }
  boardFile.writeAsStringSync(newLines.join('\n'));

  // Update NumberFormat.currency and other US symbols
  final dir = Directory('lib');
  for (var file in dir.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      var content = file.readAsStringSync();
      var newContent = content.replaceAll(
          "NumberFormat.currency(locale: 'en_US', symbol: '\\\$', decimalDigits: 0)",
          "NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)");

      // Change literal '\$ ' to 'Rp '
      newContent = newContent.replaceAll("prefixText: '\\\$ '", "prefixText: 'Rp '");
      // Change '+\$' to '+Rp'
      newContent = newContent.replaceAll("+\\\$", "+Rp");
      // Change '+ Collect \$200'
      newContent = newContent.replaceAll("+ Collect \\\$200", "+ Terima Rp2.000.000");

      if (content != newContent) {
        file.writeAsStringSync(newContent);
        print('Fixed ${file.path}');
      }
    }
  }
}
