import 'package:flutter/material.dart';

import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({
    super.key,
    required this.title,
    this.onNotificationsTap,
    this.hasUnreadNotifications = false,
  });

  final String title;
  final VoidCallback? onNotificationsTap;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: ZolyaTypography.displayMedium),
        ),
        ZolyaNotificationBell(
          onTap: onNotificationsTap,
          hasUnread: hasUnreadNotifications,
        ),
      ],
    );
  }
}
