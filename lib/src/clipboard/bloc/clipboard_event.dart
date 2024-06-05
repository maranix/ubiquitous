part of 'clipboard_bloc.dart';

sealed class ClipboardEvent extends Equatable {
  const ClipboardEvent();

  @override
  List<Object> get props => [];
}

final class _ClipboardChanged extends ClipboardEvent {
  const _ClipboardChanged(this.data);

  final ClipboardData data;

  @override
  List<Object> get props => [data];
}

final class ClipboardPurged extends ClipboardEvent {
  const ClipboardPurged();
}
