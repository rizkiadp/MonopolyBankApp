import 'dart:io';

void main() {
  final dir = Directory('lib');
  for (var file in dir.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      var content = file.readAsStringSync();
      var newContent = content.replaceAllMapped(RegExp(r'\.withOpacity\(([^)]+)\)'), (m) => '.withValues(alpha: ${m.group(1)})');
      if (content != newContent) {
        file.writeAsStringSync(newContent);
        print('Fixed ${file.path}');
      }
    }
  }
}
