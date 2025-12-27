import 'package:ap_project/screens/bill_payment/bill_payment_screen.dart';
import 'package:ap_project/screens/card_to_card/card_to_card_screen.dart';
import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/account.dart';


class AccountsListScreen extends StatefulWidget {
  const AccountsListScreen({super.key});

  State<AccountsListScreen> createState() => _AccountsListScreenState();
}

class _AccountsListScreenState extends State<AccountsListScreen> {
  TextEditingController searchController = TextEditingController();
  List<Account> filteredAccounts = [];

  @override
  void initState() {
    super.initState();
    filteredAccounts = List.from(FakeData.accounts);
  }

  IconData _getIcon(String type) {
    return type == 'جاری' ? Icons.account_balance : Icons.savings;
  }

  @override
  Widget build(BuildContext context) {
    final List<Account> accounts = FakeData.accounts;

    return Scaffold(
      appBar: AppBar(title: const Text('مدیریت حساب ها'), centerTitle: true),
      actions: [
        //ایجاد حساب جدید
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                TextEditingController typeController = TextEditingController();
                TextEditingController balanceController = TextEditingController();

                return AlertDialog(
                  title: const Text('ایجاد حساب جدید'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: typeController,
                        decoration: const InputDecoration(
                          labelText: 'نوع حساب',
                        ),
                      ),
                      TextField(
                        controller: balanceController,
                        decoration: const InputDecoration(
                          labelText: 'موجودی اولیه',
                        ),
                        keyboardType: TextInput.number,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('لغو'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final newAccount = Account(
                            id: DateTime.now().toString(),
                            type: typeController.text,
                            balance:
                            int.tryParse(balanceController.text) ?? 0,
                          );
                          accounts.add(newAccount);
                          filteredAccounts.add(newAccount);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('ایجاد'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
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

          //نوار جستجو
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'جستجوی حساب',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filteredAccounts =
                      accounts.where((a) =>
                      a.type.contains(value) ||
                          a.id.contains(value)).toList();
                });
              },
            ),
          ),

          //لیست حساب ها
          Expanded(
            child: ListView.builder(
              itemCount: filteredAccounts.length,
              itemBuilder: (context, index) {
                final account = filteredAccounts[index];
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
