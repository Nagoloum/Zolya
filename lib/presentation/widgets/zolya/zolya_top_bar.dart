import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../theme/zolya_theme.dart';

class ZolyaTopBar extends StatelessWidget implements PreferredSizeWidget {
  const ZolyaTopBar({
    super.key,
    this.title,
    this.showBack = true,
    this.onBack,
    this.actions = const [],
    this.bottom,
    this.centerTitle = false,
    this.backgroundColor,
  });

  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
            )
          : null,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      leading: showBack
          ? IconButton(
              icon: Icon(LucideIcons.chevronLeft, color: scheme.onSurface),
              onPressed: onBack ??
                  () {
                    if (context.canPop()) {
                      context.pop();
                    } else if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      context.go(RouteNames.marketplace);
                    }
                  },
            )
          : null,
      automaticallyImplyLeading: showBack,
      actions: actions
          .map((w) => Padding(
                padding: const EdgeInsets.only(right: ZolyaSpacing.xs),
                child: w,
              ))
          .toList(),
      bottom: bottom,
    );
  }
}
