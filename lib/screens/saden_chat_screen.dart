import 'package:flutter/material.dart';
import 'dart:math';
import '../services/saden_ai_service.dart';

class SadenChatScreen extends StatefulWidget {
  final String characterId;
  final String characterName;

  const SadenChatScreen({
    super.key,
    required this.characterId,
    this.characterName = 'سادن بن راشد',
  });

  @override
  State<SadenChatScreen> createState() => _SadenChatScreenState();
}

class _SadenChatScreenState extends State<SadenChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _ai = SadenAiService();

  final List<_ChatItem> _messages = [];
  bool _sending = false;
  bool _loadingHistory = true;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _sending) return;

    _controller.clear();

    setState(() {
      _messages.add(_ChatItem(text: text, isUser: true));
      _sending = true;
    });

    _scrollToBottom();

    try {
      final reply = await _ai.sendMessage(
        characterId: widget.characterId,
        message: text,
      );

      // سادن لا يرد فورًا مثل الآلة.
      // الردود الأطول تأخذ وقتًا أطول قليلًا.
      final delayMs = min(
        5000,
        max(2000, 1800 + reply.length * 12),
      );

      await Future.delayed(Duration(milliseconds: delayMs));

      if (!mounted) return;

      setState(() {
        _messages.add(
          _ChatItem(
            text: reply.isEmpty
                ? 'سادن لم يجب هذه المرة.'
                : reply,
            isUser: false,
          ),
        );
        _sending = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sending = false;
        _messages.add(
          const _ChatItem(
            text: 'سادن صمت قليلًا... حاول مرة أخرى.',
            isUser: false,
          ),
        );
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B101C),
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.characterName,
              style: const TextStyle(
                color: Color(0xFFE8D39A),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'سادن الليل',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'جلس سادن في الظلام...\n\nقل له شيئًا، وربما يقرر أن يجيب.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                          height: 1.7,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_sending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_sending && index == _messages.length) {
                        return const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'سادن يفكر...',
                              style: TextStyle(
                                color: Color(0xFFE8D39A),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        );
                      }

                      final item = _messages[index];

                      return Align(
                        alignment: item.isUser
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 330,
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: item.isUser
                                ? const Color(0xFF151C29)
                                : const Color(0xFF211D17),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: item.isUser
                                  ? Colors.white10
                                  : const Color(0xFFE8D39A).withOpacity(.18),
                            ),
                          ),
                          child: Text(
                            item.text,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.6,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: const BoxDecoration(
                color: Color(0xFF0B101C),
                border: Border(
                  top: BorderSide(color: Colors.white10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_sending,
                      textDirection: TextDirection.rtl,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اكتب لسادن...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF121925),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send_rounded),
                    color: const Color(0xFFE8D39A),
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

class _ChatItem {
  final String text;
  final bool isUser;

  const _ChatItem({
    required this.text,
    required this.isUser,
  });
}
