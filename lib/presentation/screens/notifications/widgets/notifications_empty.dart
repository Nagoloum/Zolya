import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../widgets/zolya/zolya.dart';

class NotificationsEmpty extends StatelessWidget {
  const NotificationsEmpty({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ZolyaEmptyState(
      icon: LucideIcons.bell,
      title: title,
      body: body,
    );
  }
}
