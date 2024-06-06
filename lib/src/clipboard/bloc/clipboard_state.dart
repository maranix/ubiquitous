part of 'clipboard_bloc.dart';

/// {@template clipboard_state}
/// Represents state of the clipboard.
/// {@endtemplate}
sealed class ClipboardState extends Equatable {
  /// {@macro clipboard_state}
  const ClipboardState();

  @override
  List<Object> get props => [];
}

/// {@template clipboard_inital_state}
/// Represents initial state of the clipboard.
/// {@endtemplate}
final class ClipboardInitial extends ClipboardState {
  /// {@macro clipboard_inital_state}
  const ClipboardInitial();
}

/// {@template clipboard_loaded_state}
/// Represents loaded state of the clipboard with data.
/// {@endtemplate}
final class ClipboardLoaded extends ClipboardState {
  /// {@macro clipboard_loaded_state}
  const ClipboardLoaded(this.contents);

  /// Collected data from the clipboard.
  final Iterable<String> contents;

  @override
  List<Object> get props => [contents];
}

/// {@template clipboard_failure_state}
/// Represents failed state of the clipboard with failure message
/// and clipboard contents at the time of failure.
/// {@endtemplate}
final class ClipboardFailure extends ClipboardState {
  /// {@macro clipboard_failure_state}
  const ClipboardFailure({
    required this.message,
    required this.contents,
  });

  /// Failure reason for the user.
  final String message;

  /// Collected data from the clipboard at the time of failure.
  final Iterable<String> contents;

  @override
  List<Object> get props => [message, contents];
}
