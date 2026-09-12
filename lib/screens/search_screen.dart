import 'package:flutter/material.dart';
import '../models/user_search_filter.dart';
import '../models/user_search_item.dart';
import '../services/user_search_service.dart';
import '../widgets/search_result_tile.dart';
import 'user_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final UserSearchService service = UserSearchService();

  List<UserSearchItem> results = [];
  bool loading = false;
  bool searched = false;

  Future<void> search() async {
    final text = controller.text.trim();

    if (text.isEmpty) {
      setState(() {
        results = [];
        searched = false;
      });
      return;
    }

    setState(() => loading = true);

    try {
      final filter = UserSearchFilter(
        name: text,
      );

      final data = await service.search(filter);

      if (!mounted) return;

      setState(() {
        results = data;
        searched = true;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        results = [];
        searched = true;
      });
    } finally {
      if (mounted) {
        setState(() => loading = false);
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
        title: const Text('البحث'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => search(),
              decoration: InputDecoration(
                hintText: 'ابحث عن شخص...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: search,
                  icon: const Icon(Icons.arrow_forward),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : !searched
                    ? const Center(
                        child: Text('ابحث عن شخص في الدجى'),
                      )
                    : results.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'ما لقينا أحد',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'يمكن الحكاية بعد ما وصلت لهنا.',
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: controller.clear,
                                  child: const Text('عدّل البحث'),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return SearchResultTile(
                                onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserProfileScreen(
                                      ),
                                  ),
                                );
                              },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
