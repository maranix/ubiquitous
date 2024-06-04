import 'package:clipboard_service/src/clipboard.dart';
import 'package:flutter/services.dart';

abstract interface class ClipboardService {
  factory ClipboardService() => ClipboardBinder();

  Stream<ClipboardData> get changes;

  Future<void> dispose();
}
