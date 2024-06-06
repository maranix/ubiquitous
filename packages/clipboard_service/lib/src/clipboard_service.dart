import 'package:clipboard_service/src/clipboard.dart';
import 'package:flutter/services.dart';

/// {@template clipboard_service}
/// Service for interacting with the clipboard.
///
/// This service provides functionalities to monitor clipboard changes.
///
/// By default, this returns a custom [ClipboardServiceImpl] instance.
///
/// Subclasses can override this to provide alternative implementations.
/// {@endtemplate}
abstract interface class ClipboardService {
  /// {@macro clipboard_service}
  factory ClipboardService() => ClipboardServiceImpl();

  /// Stream that emits events whenever the clipboard content changes.
  ///
  /// This stream allows listening for updates to the clipboard data.
  Stream<ClipboardData> get changes;

  /// Releases any resources associated with the service.
  ///
  /// This method should be called when the service is no longer needed to
  /// ensure proper cleanup and avoid resource leaks.
  Future<void> dispose();
}
