import 'package:ap_project/screens/bill_payment/bill_payment_screen.dart';
import 'package:ap_project/screens/card_to_card/card_to_card_screen.dart';
import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/account.dart';

class AccountsListScreen extends StatelessWidget {
  const AccountsListScreen({super.key});

  IconData _getIcon(String type) {
    return type == 'جاری' ? Icons.account_balance : Icons.savings;
  }

  @override
  Widget build(BuildContext context) {
    final List<Account> accounts = FakeData.accounts;

    return Scaffold(
      appBar: AppBar(title: const Text('مدیریت حساب ها'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.credit_card),
                    label: const Text('کارت به کارت'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CardToCardScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.receipt_long),
                    label: const Text('پرداخت قبض'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BillPaymentScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(_getIcon(account.type), size: 32),
                    title: Text(' حساب${account.type}'),
                    subtitle: Text(account.id),
                    trailing: Text(
                      '${account.balance}تومان ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
