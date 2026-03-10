enum ScanType {
  chance,
  community,
  property,
  trainRandom,
  trainFree,
  tax,
  playerTransfer,
  unhandled
}

class ScanResult {
  final ScanType type;
  final String? payload;
  final String? message;

  ScanResult(this.type, {this.payload, this.message});
}
