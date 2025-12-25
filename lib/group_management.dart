import 'package:flutter/material.dart';
import 'data/fake_data.dart';
import 'models/group.dart';

class GroupsManagementPage extends StatelessWidget {
  const GroupsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = FakeData.groups;

    if (groups.isEmpty) {
      return Center(
        child: Text(
          'گروهی برای نمایش وجود ندارد',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: groups.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final g = groups[index];

        return Card(
          child: ListTile(
            title: Text(
              g.name,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              '${g.members.length} عضو',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            trailing: const Icon(Icons.chevron_left),
          ),
        );
      },
    );
  }
}
