import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clipboard_service/clipboard_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'clipboard_event.dart';
part 'clipboard_state.dart';

/// {@template clipboard_bloc}
/// Clipboard BLoC responsible for managing clipboard related actions.
///
/// Requires a `ClipboardService` to interact with the clipboard.
/// {@endtemplate}
final class ClipboardBloc extends Bloc<ClipboardEvent, ClipboardState> {
  /// {@macro clipboard_bloc}
  ClipboardBloc({
    required ClipboardService service,
  })  : _service = service,
        super(const ClipboardInitial()) {
    on<_ClipboardChanged>(_onChanged);
    on<ClipboardPurged>(_onPurged);

    _clipboardSubscription = _service.changes.listen(_changeListener);
  }

  /// Service used to interact with the clipboard on the platform side.
  final ClipboardService _service;

  /// Stream subscription of clipboard changes.
  StreamSubscription<ClipboardData>? _clipboardSubscription;

  /// Internal list to store clipboard content history.
  final List<String> _clipboardContents = [];

  /// Provides a lazy read-only reversed view of the clipboard content history.
  Iterable<String> get _contentStack => _clipboardContents.reversed;

  void _onChanged(
    _ClipboardChanged event,
    Emitter<ClipboardState> emit,
  ) {
    final data = event.data.text;
    if (data == null) return;

    _clipboardContents.add(data);
    emit(ClipboardLoaded(_contentStack));
  }

  void _onPurged(
    ClipboardPurged event,
    Emitter<ClipboardState> emit,
  ) {
    _clipboardContents.clear();

    emit(ClipboardLoaded(_contentStack));
  }

  /// Listens to clipboard changes from the service and adds a corresponding
  /// `_ClipboardChanged` event to the bloc.
  void _changeListener(ClipboardData data) {
    add(_ClipboardChanged(data));
  }

  @override
  Future<void> close() {
    _clipboardSubscription?.cancel();
    _clipboardContents.clear();
    _service.dispose();

    return super.close();
  }
}
