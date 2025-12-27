import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;

  void initState() {
    super.initState();
    user = FakeData.currentUser;
  }

  void SwitchUser() {
    setState(() {
      if (FakeData.currentUser == FakeData.users[0]) {
        FakeData.currentUser = FakeData.users[1];
      } else {
        FakeData.currentUser = FakeData.users[0];
      }
      user = FakeData.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FakeData.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('پروفایل کاربری'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '@${user.username}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            //دکمه سوییچ یوزر
            ElevatedButton.icon(
              onPressed: SwitchUser,
              icon: const Icon(Icons.switch_account),
              label: const Text('تغییر کاربر'),
            ),
            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('ویرایش اطلاعات'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('خروج از حساب'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  ),
                    (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
