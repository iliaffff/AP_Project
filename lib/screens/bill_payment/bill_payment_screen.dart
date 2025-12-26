import 'package:flutter/material.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  final TextEditingController billIdController = TextEditingController();
  final TextEditingController paymentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پرداخت قبض'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: billIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'شناسه قبض',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: paymentIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'شناسه پرداخت',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                //نمایش پیام موفقیت
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('قبض با موفقیت پرداخت شد'),
                    backgroundColor: Colors.green,
                  ),
                );
                //پاک کردن فرم
                billIdController.clear();
                paymentIdController.clear();
              },
              child: const Text('پرداخت قبض'),
            ),
          ],
        ),
      ),
    );
  }
}
