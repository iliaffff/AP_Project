import 'package:flutter/material.dart';
import '../../data/fake_data.dart';

class AccountsListScreen extends StatelessWidget {
  const AccountsListScreen ({super.key});

  Widget build(BuildContext context) {
    final accounts = FakeData.accounts;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب های من'),
      ),
      body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(' حساب${account.type}'),
              subtitle: Text(account.id),
              trailing: Text(
                '${account.balance}تومان '
              ),
              onTap: () {
                // بعدا جزئیات حساب رو اضافه میکنم بهش
              },
            ),
          );
          },
      ),
    );
  }
}