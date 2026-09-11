import '../models/message_guard_result.dart';

class MessageContentGuard {
  static const List<String> blockedWords = [
    'كلمة_مسيئة_1',
    'كلمة_مسيئة_2',
    'كلمة_مسيئة_3',
  ];

  MessageGuardResult check(String value) {
    final text = value.trim();

    if (text.isEmpty) {
      return MessageGuardResult.block('اكتب الرسالة أولاً');
    }

    if (text.length > 2000) {
      return MessageGuardResult.block('الرسالة طويلة جداً، الحد الأقصى 2000 حرف');
    }

    final normalized = _normalize(text);

    for (final word in blockedWords) {
      if (normalized.contains(_normalize(word))) {
        return MessageGuardResult.block('خلّينا نحافظ على احترام الحوار، جرّب صياغة الرسالة بطريقة ثانية.');
      }
    }

    return MessageGuardResult.allow(text);
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r"[\\u064B-\\u065F\\u0670]"), "")
        .replaceAll("أ", "ا")
        .replaceAll("إ", "ا")
        .replaceAll("آ", "ا")
        .replaceAll("ٱ", "ا")
        .replaceAll("ة", "ه")
        .replaceAll(
          RegExp(r"[^\\u0600-\\u06FFa-zA-Z0-9]+"),
          "",
        );
  }
}
