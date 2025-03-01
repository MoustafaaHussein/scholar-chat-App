part of 'chat_cubit_cubit.dart';

@immutable
sealed class ChatStates {}

final class ChatInitial extends ChatStates {}

final class ChatSuccess extends ChatStates {
  final List<Messagesmodel> messagesList;

  ChatSuccess({required this.messagesList});
}

final class ChatFailure extends ChatStates {}
