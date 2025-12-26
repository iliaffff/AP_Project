import 'package:flutter/material.dart';
import 'account_management.dart';
import 'group_management.dart';
import 'theme_controller.dart';
import 'screens/transfer_screen.dart';
import 'screens/card_to_card_screen.dart';
import 'screens/bill_payment_screen.dart';
import 'screens/profile_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;

  final List<Widget> _pages = const [
    GroupsManagementPage(),
    AccountsManagementPage(),
    DashboardContent(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    'گروه‌ها',
    'حساب‌ها',
    'خانه',
    'پروفایل',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AppTopBar(
                title: _titles[_currentIndex],
                showBack: false,
              ),
              Expanded(child: _pages[_currentIndex]),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'خانه'),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'حساب‌ها',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'گروه‌ها'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'پروفایل'),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  static String _formatMoney(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final double totalBalance = 12450000;

    final List<Map<String, dynamic>> recentTransactions = [
      {'date': '۱۴۰۴/۱۰/۰۴', 'title': 'واریز حقوق', 'amount': 8200000},
      {'date': '۱۴۰۴/۱۰/۰۳', 'title': 'کارت به کارت', 'amount': -500000},
      {'date': '۱۴۰۴/۱۰/۰۲', 'title': 'پرداخت قبض', 'amount': -120000},
      {'date': '۱۴۰۴/۱۰/۰۱', 'title': 'واریز از دوست', 'amount': 300000},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
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
                            fontWeight: FontWeight.w900,
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 96,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _quickAction(
                  context,
                  Icons.credit_card,
                  'کارت به کارت',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CardToCardScreen()),
                    );
                  },
                ),
                _quickAction(
                  context,
                  Icons.swap_horiz,
                  'انتقال وجه',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TransferScreen()),
                    );
                  },
                ),
                _quickAction(
                  context,
                  Icons.receipt_long,
                  'پرداخت قبض',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BillPaymentScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          const Text(
            'تراکنش‌های اخیر',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),

          ...recentTransactions.map((tx) => _transactionItem(context, tx)),
        ],
      ),
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
    final num amountAbs = (tx['amount'] as num).abs();
    final Color color = isPositive ? Colors.greenAccent : Colors.redAccent;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          isPositive ? Icons.arrow_downward : Icons.arrow_upward,
          color: color,
        ),
        title: Text(
          tx['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          tx['date'] as String,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        trailing: Text(
          '${_formatMoney(amountAbs)} تومان',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ),
    );
  }
}
