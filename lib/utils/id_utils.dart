import 'dart:math';

String generateId() {
  final rand = Random();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final r = rand.nextInt(100000);
  return '$timestamp$r';
}
