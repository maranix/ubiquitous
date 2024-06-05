import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clipboard_service/clipboard_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'clipboard_event.dart';
part 'clipboard_state.dart';

final class ClipboardBloc extends Bloc<ClipboardEvent, ClipboardState> {
  ClipboardBloc({
    required ClipboardService service,
  })  : _service = service,
        super(const ClipboardInitial()) {
    on<_ClipboardChanged>(_onChanged);
    on<ClipboardPurged>(_onPurged);

    _clipboardSubscription = _service.changes.listen(_changeListener);
  }

  final ClipboardService _service;

  StreamSubscription<ClipboardData>? _clipboardSubscription;

  final List<String> _clipboardContents = [];

  Iterable<String> get _contentStack => _clipboardContents.reversed;

  void _onChanged(
    _ClipboardChanged event,
    Emitter<ClipboardState> emit,
  ) {
    final data = event.data.text;
    if (data == null) return;

    _clipboardContents.add(data);
    emit(
      ClipboardContents(_contentStack),
    );
  }

  void _onPurged(
    ClipboardPurged event,
    Emitter<ClipboardState> emit,
  ) {
    _clipboardContents.clear();

    emit(
      ClipboardContents(_contentStack),
    );
  }

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
