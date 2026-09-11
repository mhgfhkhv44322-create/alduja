import 'package:flutter/material.dart';
import '../services/city_chat_service.dart';

class CityChatScreen extends StatefulWidget {
  final String cityId;
  final String cityName;

  const CityChatScreen({
    super.key,
    required this.cityId,
    required this.cityName,
  });

  @override
  State<CityChatScreen> createState() => _CityChatScreenState();
}

class _CityChatScreenState extends State<CityChatScreen> {
  final service = CityChatService();
  final controller = TextEditingController();

  late Future<List<Map<String, dynamic>>> messagesFuture;
  bool sending = false;

  @override
  void initState() {
    super.initState();
    messagesFuture = service.getMessages(widget.cityId);
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();

    if (text.isEmpty || sending) return;

    setState(() => sending = true);

    try {
      await service.sendMessage(
        cityId: widget.cityId,
        text: text,
      );

      controller.clear();

      setState(() {
        messagesFuture = service.getMessages(widget.cityId);
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => sending = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شات ${widget.cityName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'تعذر تحميل رسائل المدينة.',
                    ),
                  );
                }

                final messages = snapshot.data ?? [];

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'ماكو رسائل بعد... كن أول من يحچي.',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          message['message_text']
                                  ?.toString() ??
                              '',
                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        hintText: 'اكتب شيئاً لأهل المدينة...',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: sending ? null : sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
