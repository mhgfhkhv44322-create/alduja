import 'package:flutter/material.dart';
import '../models/user_search_item.dart';

class SearchResultTile extends StatelessWidget {
  final UserSearchItem user;
  final VoidCallback? onTap;

  const SearchResultTile({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: user.avatarUrl != null
              ? NetworkImage(user.avatarUrl!)
              : null,
          child: user.avatarUrl == null
              ? const Icon(Icons.person_outline)
              : null,
        ),
        title: Text(
          user.displayName?.trim().isNotEmpty == true
              ? user.displayName!
              : user.username,
        ),
        subtitle: user.title?.trim().isNotEmpty == true
            ? Text(user.title!)
            : Text('@${user.username}'),
        trailing: const Icon(
          Icons.chevron_left,
        ),
      ),
    );
  }
}
