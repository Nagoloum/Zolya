import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaListTile extends StatelessWidget {
  const ZolyaListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron = true,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final chevronColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    final hasAction = onTap != null;
    final effectiveTrailing = trailing ??
        (hasAction && showChevron
            ? Icon(LucideIcons.chevronRight, size: 18, color: chevronColor)
            : null);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.lg,
            vertical: dense ? ZolyaSpacing.sm : ZolyaSpacing.md,
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: ZolyaSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: ZolyaTypography.body
                          .copyWith(color: scheme.onSurface),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: ZolyaSpacing.xs / 2),
                      Text(
                        subtitle!,
                        style: ZolyaTypography.bodySmall
                            .copyWith(color: mutedColor),
                      ),
                    ],
                  ],
                ),
              ),
              if (effectiveTrailing != null) ...[
                const SizedBox(width: ZolyaSpacing.sm),
                effectiveTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
