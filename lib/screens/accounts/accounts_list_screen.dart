import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/account.dart';

class AccountsListScreen extends StatelessWidget {
  const AccountsListScreen ({super.key});

  IconData _getIcon(String type) {
    return type == 'جاری' ? Icons.account_balance : Icons.savings;
  }

  Widget build(BuildContext context) {
    final List<Account> accounts = FakeData.accounts;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت حساب ها'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                _getIcon(account.type),
                size: 32,
              ),
              title: Text(' حساب${account.type}'),
              subtitle: Text(account.id),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'موجودی',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${account.balance}تومان ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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