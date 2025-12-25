import 'package:flutter/material.dart';
import 'account_management.dart';
import 'group_management.dart';
import 'data/fake_data.dart';
import 'models/account.dart';
import 'screens/transfer_screen.dart';
import 'theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardContent(),
    AccountsManagementPage(),
    GroupsManagementPage(),
  ];

  final List<String> _titles = const [
    'داشبورد',
    'حساب‌ها',
    'گروه‌ها',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(title: _titles[_currentIndex]),
            Expanded(child: _pages[_currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'حساب‌ها'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'گروه‌ها'),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final List<Account> accounts = FakeData.accounts;
    final double totalBalance = accounts.fold<double>(0, (sum, a) => sum + a.balance);

    final List<Map<String, dynamic>> recentTransactions = [
      {'date': '۱۴۰۴/۰۴/۰۳', 'title': 'انتقال به محمد', 'amount': -500000},
      {'date': '۱۴۰۴/۰۴/۰۲', 'title': 'واریز حقوق', 'amount': 8200000},
    ];

    return RefreshIndicator(
      onRefresh: () async => Future.delayed(const Duration(milliseconds: 700)),
      color: cs.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded, color: cs.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'موجودی کل',
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${_formatMoney(totalBalance)} تومان',
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            const Text(
              'عملیات سریع',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 104,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _quickAction(context, Icons.payment, 'کارت به کارت', onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('کارت به کارت (بعداً)')),
                    );
                  }),
                  _quickAction(context, Icons.swap_horiz, 'انتقال وجه', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TransferScreen()),
                    );
                  }),
                  _quickAction(context, Icons.receipt_long, 'پرداخت قبض', onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('پرداخت قبض (بعداً)')),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'تراکنش‌های اخیر',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            ...recentTransactions.map((tx) => _transactionItem(context, tx)),
          ],
        ),
      ),
    );
  }

  static String _formatMoney(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    );
  }

  static Widget _quickAction(
      BuildContext context,
      IconData icon,
      String label, {
        required VoidCallback onTap,
      }) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          children: [
            Card(
              child: SizedBox(
                width: 58,
                height: 58,
                child: Icon(icon, color: cs.primary),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _transactionItem(BuildContext context, Map<String, dynamic> tx) {
    final bool isPositive = (tx['amount'] as num) > 0;
    final color = isPositive ? Colors.greenAccent : Colors.redAccent;

    return Card(
      child: ListTile(
        trailing: Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: color),
        title: Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(tx['date'], style: TextStyle(color: Theme.of(context).hintColor)),
        leading: Text(
          '${_formatMoney((tx['amount'] as num).abs())} تومان',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: color, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
