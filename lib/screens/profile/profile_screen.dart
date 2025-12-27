import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/user.dart';
import '../splash/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = FakeData.currentUser;
  }

  void switchUser() {
    setState(() {
      if (FakeData.currentUser == FakeData.users[0]) {
        FakeData.currentUser = FakeData.users[1];
      } else {
        FakeData.currentUser = FakeData.users[0];
      }
      user = FakeData.currentUser;
    });
  }

  void _editUserName(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: user.name);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('ویرایش اطلاعات'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'نام'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  user = User(
                    name: nameController.text,
                    username: user.username,
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('ذخیره'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              '@${user.username}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // سوییچ کاربر (نمایشی)
            ElevatedButton.icon(
              onPressed: switchUser,
              icon: const Icon(Icons.switch_account),
              label: const Text('تغییر کاربر'),
            ),

            const SizedBox(height: 30),

            // ویرایش اطلاعات
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('ویرایش اطلاعات'),
              onTap: () => _editUserName(context),
            ),

            // خروج از حساب
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
