import 'package:flutter/material.dart';
import '../data/fake_data.dart';
import '../models/account.dart';


class ThemeController {
  static final ValueNotifier<ThemeMode> mode =
  ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void toggle() {
    mode.value =
    (mode.value == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

class AppTopBar extends StatelessWidget {
  final String title;
  final bool showBack;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.isDark(context);

    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            Positioned(
              left: 8,
              child: IconButton(
                tooltip: isDark ? 'Light mode' : 'Night mode',
                onPressed: ThemeController.toggle,
                icon: Icon(
                  isDark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
            ),

            if (showBack)
              Positioned(
                right: 8,
                child: IconButton(
                  tooltip: 'بازگشت',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
