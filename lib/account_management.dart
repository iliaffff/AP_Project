import 'package:flutter/material.dart';
import 'data/fake_data.dart';
import 'models/account.dart';

class AccountsManagementPage extends StatelessWidget {
  const AccountsManagementPage({super.key});

  static String _formatMoney(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final List<Account> accounts = FakeData.accounts;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      itemCount: accounts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final a = accounts[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.55 : 1,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white10
                  : Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_formatMoney(a.balance)}',
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'تومان',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'حساب ${a.type}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    a.id,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ],
              ),

              const SizedBox(width: 14),

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.25 : 0.15,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: cs.primary,
                  size: 22,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
