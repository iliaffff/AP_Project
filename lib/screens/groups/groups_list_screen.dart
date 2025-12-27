import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import 'package:ap_project/screens/groups/add_group_screen.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = FakeData.groups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('گروه‌های مشترک'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddGroupScreen(),
                ),
              );
            },
          ),
        ],
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