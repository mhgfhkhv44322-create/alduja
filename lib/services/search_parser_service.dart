class SearchParserService {
  static SearchType detect(String value) {
    final text = value.trim();

    if (text.isEmpty) {
      return SearchType.none;
    }

    if (_looksLikeId(text)) {
      return SearchType.userId;
    }

    return SearchType.text;
  }

  static bool _looksLikeId(String value) {
    final uuid = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
    );

    return uuid.hasMatch(value);
  }
}

enum SearchType {
  none,
  text,
  userId,
}
