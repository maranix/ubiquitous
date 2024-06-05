import 'package:clipboard_service/src/clipboard.dart';
import 'package:flutter/services.dart';

abstract interface class ClipboardService {
  factory ClipboardService() => ClipboardServiceImpl();

  Stream<ClipboardData> get changes;

  Future<void> dispose();
}
