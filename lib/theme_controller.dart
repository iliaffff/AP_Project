import 'package:flutter/material.dart';


class ThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void toggle() {
    mode.value = (mode.value == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

class AppTopBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final Widget? trailing;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = ThemeController.isDark(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: SizedBox(
        height: 56,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Title center
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            Positioned(
              left: 0,
              child: IconButton(
                tooltip: isDark ? 'حالت روشن' : 'حالت تیره',
                onPressed: ThemeController.toggle,
                icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
                color: cs.onSurface,
              ),
            ),

            if (showBack)
              Positioned(
                right: 0,
                child: IconButton(
                  tooltip: 'بازگشت',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  color: cs.onSurface,
                ),
              ),

            if (!showBack && trailing != null)
              Positioned(
                right: 0,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
