import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'cubit/bot_cubit.dart';
import 'cubit/bot_state.dart';
import 'modle/massage_modle.dart';

class BotScreen extends StatelessWidget {
  const BotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BotCubit(),
      child: BotView(),
    );
  }
}

// bot_view.dart
class BotView extends StatefulWidget {
  const BotView({super.key});

  @override
  State<BotView> createState() => _BotViewState();
}

class _BotViewState extends State<BotView> {
  final TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyCmxiF-wOE4sXN5aY3smg8cZF-UcwnoUh4";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini AI Bot'),
      ),
      body: Container(
         decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 253, 194, 253), // الأحمر
              Color.fromARGB(255, 183, 216, 245), // الأزرق
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: BlocBuilder<BotCubit, BotState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
        
                  if (state.errorMessage.isNotEmpty) {
                    return Center(child: Text(state.errorMessage));
                  }
        
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat('HH:mm').format(message.date),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userMessage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(10)),
                        label: const Text("....اسالني عن حلمك  "),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    onPressed: () {
                      final userMessage = _userMessage.text;
                      _userMessage.clear();
                      context.read<BotCubit>().sendMessage(userMessage, model);
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
