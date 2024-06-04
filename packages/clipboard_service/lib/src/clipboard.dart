import 'dart:async';

import 'package:clipboard_service/clipboard_service.dart';
import 'package:flutter/services.dart';

final class ClipboardBinder with ClipboardListener implements ClipboardService {
  ClipboardBinder() : this._();

  ClipboardBinder._() {
    _streamController = StreamController<ClipboardData>();

    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
  }

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
