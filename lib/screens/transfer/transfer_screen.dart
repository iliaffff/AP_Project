import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/account.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  Account? selectedAccount;
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accounts = FakeData.accounts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('انتقال وجه'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<Account>(
              decoration: const InputDecoration(
                labelText: 'حساب مبدا',
                border: OutlineInputBorder(),
              ),
              items: accounts.map((account) {
                return DropdownMenuItem(
                  value: account,
                  child: Text('${account.type} -${account.id}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAccount = value;
                });
              },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  labelText: 'شماره حساب مقصد',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'مبلغ (تومان)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {
          //انتقال وجه
        },
        child: const Text('انتقال'),
      ),
          ],
        ),
      ),
    );
  }
}