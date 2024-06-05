part of 'clipboard_bloc.dart';

sealed class ClipboardState extends Equatable {
  const ClipboardState();

  @override
  List<Object> get props => [];
}

final class ClipboardInitial extends ClipboardState {
  const ClipboardInitial();
}

final class ClipboardContents extends ClipboardState {
  const ClipboardContents(this.contents);

  final Iterable<String> contents;

  @override
  List<Object> get props => [contents];
}

final class ClipboardFailure extends ClipboardState {
  const ClipboardFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
