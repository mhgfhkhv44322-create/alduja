import '../models/inbox_message.dart';

class InboxParserService {
  List<InboxMessage> parse(
    List<Map<String, dynamic>> data,
  ) {
    return data
        .map(InboxMessage.fromMap)
        .toList();
  }
}
