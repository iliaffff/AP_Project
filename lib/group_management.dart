import 'package:flutter/material.dart';
import 'data/fake_data.dart';
import 'models/group.dart';

class GroupsManagementPage extends StatelessWidget {
  const GroupsManagementPage({super.key});

  static String _formatMoney(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final List<Group> groups = FakeData.groups;

    final Map<String, int> myGroupNet = {
      'دوستان سفر شمال': 485000,
      'سفر شمال': 485000,
      'خانه اشتراکی': -230000,
      'خانه دانشجویی': -230000,
    };

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      itemCount: groups.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final g = groups[index];

        final int net = myGroupNet[g.name] ?? 0;
        final bool isCreditor = net >= 0;

        final Color statusColor = net == 0
            ? Theme.of(context).hintColor
            : (isCreditor ? Colors.greenAccent : Colors.redAccent);

        final String statusText = net == 0
            ? 'تسویه'
            : isCreditor
            ? 'طلبکار ${_formatMoney(net)} تومان'
            : 'بدهکار ${_formatMoney(net.abs())} تومان';

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
              Text(
                statusText,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    g.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${g.members.length} عضو',
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
                  Icons.group_rounded,
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
