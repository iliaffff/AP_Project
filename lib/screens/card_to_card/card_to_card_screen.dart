import 'package:flutter/material.dart';
import '../../data/fake_data.dart';
import '../../models/account.dart';

class CardToCardScreen extends StatefulWidget {
  const CardToCardScreen({super.key});

  @override
  State<CardToCardScreen> createState() => _CardToCardScreenState();
}

class _CardToCardScreenState extends State<CardToCardScreen> {
  Account? selectedAccount;
  final TextEditingController destinationCardController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accounts = FakeData.accounts;

    return Scaffold(
      appBar: AppBar(title: const Text('کارت به کارت'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<Account>(
              decoration: const InputDecoration(
                labelText: 'کارت مبدا',
                border: OutlineInputBorder(),
              ),
              items: accounts.map((account) {
                return DropdownMenuItem(
                  value: account,
                  child: Text('${account.type} - ${account.id}'),
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
              controller: destinationCardController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'شماره کارت مقصد',
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
                if (destinationCardController.text.isEmpty ||
                    amountController.text.isEmpty ||
                    selectedAccount == null) {
                  //نمایش پیام خطا
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لطفا همه فیلد ها را پر کنید'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                //نمایش پیام موفقیت
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('کارت به کارت با موفقیت انجام شد'),
                    backgroundColor: Colors.green,
                  ),
                );
                //پاک کردن فرم
                destinationCardController.clear();
                amountController.clear();
                setState(() {
                  selectedAccount = null;
                });
              },
              child: const Text('انجام کارت به کارت'),
            ),
          ],
        ),
      ),
    );
  }
}
