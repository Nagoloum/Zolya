import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

enum ZolyaAlertVariant { info, success, warning, error }

class ZolyaAlert extends StatelessWidget {
  const ZolyaAlert({
    super.key,
    required this.title,
    this.message,
    this.variant = ZolyaAlertVariant.info,
    this.icon,
    this.onClose,
  });

  final String title;
  final String? message;
  final ZolyaAlertVariant variant;
  final IconData? icon;
  final VoidCallback? onClose;

  ({Color bg, Color fg, Color border, IconData defaultIcon}) get _spec {
    return switch (variant) {
      ZolyaAlertVariant.info => (
          bg: ZolyaColors.infoBg,
          fg: ZolyaColors.info,
          border: ZolyaColors.info.withValues(alpha: 0.2),
          defaultIcon: LucideIcons.info,
        ),
      ZolyaAlertVariant.success => (
          bg: ZolyaColors.succesBg,
          fg: ZolyaColors.succes,
          border: ZolyaColors.succes.withValues(alpha: 0.2),
          defaultIcon: LucideIcons.circleCheck,
        ),
      ZolyaAlertVariant.warning => (
          bg: ZolyaColors.avertissementBg,
          fg: ZolyaColors.avertissement,
          border: ZolyaColors.avertissement.withValues(alpha: 0.2),
          defaultIcon: LucideIcons.triangleAlert,
        ),
      ZolyaAlertVariant.error => (
          bg: ZolyaColors.erreurBg,
          fg: ZolyaColors.erreur,
          border: ZolyaColors.erreur.withValues(alpha: 0.2),
          defaultIcon: LucideIcons.circleX,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final s = _spec;
    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: s.bg,
        border: Border.all(color: s.border),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? s.defaultIcon, size: 18, color: s.fg),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: ZolyaTypography.bodySmall.copyWith(
                    color: s.fg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    message!,
                    style: ZolyaTypography.bodySmall.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.65)),
                  ),
                ],
              ],
            ),
          ),
          if (onClose != null) ...[
            const SizedBox(width: ZolyaSpacing.sm),
            InkWell(
              onTap: onClose,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(LucideIcons.x, size: 14, color: s.fg),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
