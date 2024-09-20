// bot_state.dart
import 'package:equatable/equatable.dart';
import '../modle/massage_modle.dart';

class BotState extends Equatable {
  final List<Message> messages;
  final bool isLoading;
  final String errorMessage;

  const BotState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  BotState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [messages, isLoading, errorMessage];
}
