import 'package:flutter/material.dart';
import '../services/reply_message_service.dart';
import '../services/chat_messages_service.dart';
import '../services/chat_read_service.dart';
import '../widgets/reply_input.dart';
import '../widgets/save_message_button.dart';
import '../widgets/block_user_button.dart';
import '../widgets/report_button.dart';

class ChatScreen extends StatefulWidget {
  final String otherUserId;
  final String? title;

  const ChatScreen({
    super.key,
    required this.otherUserId,
    this.title,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ReplyMessageService replyService =
      ReplyMessageService();

  final ChatMessagesService chatMessagesService =
      ChatMessagesService();

  final ChatReadService chatReadService =
      ChatReadService();

  final List<Map<String, dynamic>> messages = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    try {
      final data = await chatMessagesService.getMessages(
        widget.otherUserId,
      );

      await chatReadService.markConversationAsRead(
        widget.otherUserId,
      );

      if (!mounted) return;

      setState(() {
        messages
          ..clear()
          ..addAll(data);
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> sendReply(String text) async {
    await replyService.sendReply(
      receiverId: widget.otherUserId,
      messageText: text,
    );

    if (!mounted) return;

    setState(() {
      messages.add({
        'message_text': text,
        'sender_id': 'me',
        'is_mine': true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'المحادثة'),
        actions: [
          BlockUserButton(userId: widget.otherUserId),
          ReportButton(userId: widget.otherUserId),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : messages.isEmpty
                    ? const Center(
                        child: Text(
                          'ابدأ الحديث برسالة...',
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return Align(
                            alignment:
                                message['is_mine'] == true
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(
                                bottom: 10,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(16),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      message['message_text'].toString(),
                                    ),
                                  ),
                                  if (message['id'] != null)
                                    SaveMessageButton(
                                      messageId: message['id'].toString(),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          ReplyInput(
            onSend: sendReply,
          ),
        ],
      ),
    );
  }
}
