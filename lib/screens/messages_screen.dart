import 'package:flutter/material.dart';
import '../models/anonymous_message.dart';
import '../services/anonymous_message_service.dart';
import '../models/character_echo.dart';
import '../services/echo_service.dart';
import 'anonymous_message_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  final _service = AnonymousMessageService();

  late TabController _tabs;
  List<AnonymousMessage> _received = [];
  List<AnonymousMessage> _sent = [];
  List<CharacterEcho> _echoes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() => _loading = true);
    try {
      final received = await _service.getReceived();
      final sent = await _service.getSent();
    final echoes = await EchoService().getCharacterEchoes('');

      if (!mounted) return;
      setState(() {
        _received = received;
        _sent = sent;
        _echoes = echoes;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF07080C),
        elevation: 0,
        title: const Text(
          'الرسائل',
          style: TextStyle(
            color: Color(0xFFE8D8B0),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _loadMessages,
            icon: const Icon(Icons.refresh_rounded),
            color: const Color(0xFFD7B97E),
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: const Color(0xFFD7B97E),
          labelColor: const Color(0xFFE8D8B0),
          unselectedLabelColor: const Color(0xFF77777F),
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'الواردة'),
            Tab(text: 'المرسلة'),
            Tab(text: 'أصداء الحكايات'),
          ],
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD7B97E),
              ),
            )
          : TabBarView(
              controller: _tabs,
              children: [
                _messageList([..._received, ..._sent]),
                _messageList(_received),
                _messageList(_sent),
                _echoList(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD7B97E),
        foregroundColor: const Color(0xFF111116),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AnonymousMessageScreen(),
            ),
          );
          if (result == true) {
            _loadMessages();
          }
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _echoList() {
    if (_echoes.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.nightlight_round,
              color: Color(0xFF5E5E67),
              size: 48,
            ),
            SizedBox(height: 14),
            Text(
              'لم يصل صدى بعد',
              style: TextStyle(
                color: Color(0xFF9B9BA3),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'بعض الحكايات تحتاج وقتاً حتى تترك أثرها',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xFF62626B),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFFD7B97E),
      backgroundColor: const Color(0xFF111218),
      onRefresh: _loadMessages,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
        itemCount: _echoes.length,
        itemBuilder: (context, index) {
          final echo = _echoes[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF101116),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF3A3022),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.nightlight_round,
                      color: Color(0xFFD7B97E),
                      size: 20,
                    ),
                    const Spacer(),
                    const Text(
                      'صدى من الحكايات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xFFE3D3AD),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  '«${echo.message}»',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFFC8B991),
                    fontSize: 15,
                    height: 1.8,
                  ),
                ),
                if (echo.createdAt != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _formatDate(echo.createdAt!),
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Color(0xFF62626B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _messageList(List<AnonymousMessage> messages) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.mark_email_unread_outlined,
              color: Color(0xFF5E5E67),
              size: 48,
            ),
            SizedBox(height: 14),
            Text(
              'لا توجد رسائل بعد',
              style: TextStyle(
                color: Color(0xFF9B9BA3),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    messages.sort((a, b) {
      final ad = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bd = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bd.compareTo(ad);
    });

    return RefreshIndicator(
      color: const Color(0xFFD7B97E),
      backgroundColor: const Color(0xFF111218),
      onRefresh: _loadMessages,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF101116),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF26262E),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFF1B1A20),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFFD7B97E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'رسالة مجهولة',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xFFE3D3AD),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message.text,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFFB8B8C0),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      if (message.createdAt != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _formatDate(message.createdAt!),
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Color(0xFF62626B),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day}/${local.month}/${local.year}';
  }
}
