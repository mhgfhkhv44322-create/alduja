import 'city_search_info.dart';
import 'user_search_item.dart';

class CitySearchResult {
  final CitySearchInfo city;
  final List<UserSearchItem> users;

  const CitySearchResult({
    required this.city,
    required this.users,
  });
}
