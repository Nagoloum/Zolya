import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaNotificationBell extends StatelessWidget {
  const ZolyaNotificationBell({
    super.key,
    this.onTap,
    this.hasUnread = false,
    this.size = 22,
  });

  final VoidCallback? onTap;
  final bool hasUnread;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                hasUnread ? LucideIcons.bellDot : LucideIcons.bell,
                size: size,
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (hasUnread)
              Positioned(
                top: 11,
                right: 11,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ZolyaColors.erreur,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: theme.scaffoldBackgroundColor, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
