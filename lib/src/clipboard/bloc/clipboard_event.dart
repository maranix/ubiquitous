part of 'clipboard_bloc.dart';

/// {@template clipboard_event}
/// Represents event related to clipboard.
/// {@endtemplate}
sealed class ClipboardEvent extends Equatable {
  /// {@macro clipboard_event}
  const ClipboardEvent();

  @override
  List<Object> get props => [];
}

/// {@template clipboard_changed_event}
/// Indicates that clipboard content was updated with [ClipboardData].
///
/// `Only to be used internally.`
/// {@endtemplate}
final class _ClipboardChanged extends ClipboardEvent {
  /// {@macro clipboard_changed_event}
  const _ClipboardChanged(this.data);

  /// Represents the data recieved from the clipboard during the change.
  final ClipboardData data;

  @override
  List<Object> get props => [data];
}

/// {@template clipboard_event}
/// Indicates that the all the saved contents of Clipboard is cleared.
/// {@endtemplate}
final class ClipboardPurged extends ClipboardEvent {
  /// {@macro clipboard_purged_event}
  const ClipboardPurged();
}
