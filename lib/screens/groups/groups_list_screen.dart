import 'package:flutter/material.dart';
import '../../data/fake_data.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  Widget build(BuildContext context) {
    final groups = FakeData.groups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('گروه های مشترک'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListTile(
              title: Text(group.name),
              subtitle: Text(' :اعضا${group.members.join(', ')}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // جزئیات گروه
              },
            ),
          );
        },
      ),
    );
  }
}