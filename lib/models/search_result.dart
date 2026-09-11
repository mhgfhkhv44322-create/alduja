import 'search_display_item.dart';

class SearchResult {
  final List<SearchDisplayItem> users;

  const SearchResult({
    this.users = const [],
  });

  bool get isEmpty => users.isEmpty;

  bool get hasResults => users.isNotEmpty;
}
