// bot_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../modle/massage_modle.dart';
import 'bot_state.dart';

class BotCubit extends Cubit<BotState> {
  BotCubit() : super(const BotState());

  void addMessage(Message message) {
    final updatedMessages = List<Message>.from(state.messages)..add(message);
    emit(state.copyWith(messages: updatedMessages));
  }

  Future<void> sendMessage(String userMessage, GenerativeModel model) async {
    final userMsg = Message(
      isUser: true,
      message: userMessage,
      date: DateTime.now(),
    );
    addMessage(userMsg);

    if (!userMessage.contains('حلم') && !userMessage.contains('رأيت') &&
        !userMessage.contains('تفسير') && !userMessage.contains('رايت') && 
        !userMessage.contains('حلمت') && !userMessage.contains('فسر')) {
      final errorMessage = Message(
        isUser: false,
        message: "الرجاء كتابة حلم لتفسيره، مثل: 'رأيت نفسي أطير في السماء'.",
        date: DateTime.now(),
      );
      addMessage(errorMessage);
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final prompt = "فسر لي هذا الحلم: $userMessage";
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      final botMsg = Message(
        isUser: false, 
        message: response.text ?? "لا يمكن تفسير الحلم الآن.", 
        date: DateTime.now(),
      );
      addMessage(botMsg);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void clearMessages() {
    emit(state.copyWith(messages: []));
  }
}
