import 'dart:async';

import 'package:clipboard_service/clipboard_service.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/services.dart';

/// {@template clipboard_service_impl}
/// Concrete implementation of the `ClipboardService` that monitors clipboard changes.
///
/// This class listens for clipboard changes using a `ClipboardListener` from `clipboard_watcher` package and emits
/// updates through a stream.
/// {@endtemplate}
final class ClipboardServiceImpl
    with ClipboardListener
    implements ClipboardService {
  /// {@macro clipboard_service_impl}
  ClipboardServiceImpl() : this._();

  /// Internal constructor used to initialize [ClipboardWatcher] and [StreamController<ClipboardData>].
  ClipboardServiceImpl._() {
    _streamController = StreamController<ClipboardData>.broadcast();

    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
  }

  /// StreamController used to manage and emit events whenever the clipboard
  /// changes.
  late final StreamController<ClipboardData> _streamController;

  @override
  Stream<ClipboardData> get changes => _streamController.stream;

  @override
  void onClipboardChanged() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data == null) return;

    _streamController.add(data);
  }

  @override
  Future<void> dispose() async {
    clipboardWatcher.removeListener(this);

    await Future.wait([
      _streamController.close(),
      clipboardWatcher.stop(),
    ]);
  }
}
