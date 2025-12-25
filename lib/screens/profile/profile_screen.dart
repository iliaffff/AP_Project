import 'package:flutter/material.dart';
import '../../data/fake_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget build(BuildContext context) {
    final user = FakeData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل کاربری'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('@${user.name}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('ویرایش اطلاعات'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('خروج از حساب'),
              onTap: () {},
            ),
          ],
        ),
        ),
      );
  }
}