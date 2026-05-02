import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';
import 'zolya_button.dart';

class ZolyaEmptyState extends StatelessWidget {
  const ZolyaEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final iconColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final bodyColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(ZolyaRadius.full),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 36, color: iconColor),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Text(
              title,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
              textAlign: TextAlign.center,
            ),
            if (body != null) ...[
              const SizedBox(height: ZolyaSpacing.sm),
              Text(
                body!,
                style: ZolyaTypography.body.copyWith(color: bodyColor),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                variant: ZolyaButtonVariant.outline,
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
