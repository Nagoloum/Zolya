import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaRadioCard extends StatelessWidget {
  const ZolyaRadioCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badge,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? badge;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final selectedBg = scheme.primary.withValues(alpha: 0.08);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(ZolyaSpacing.md + 2),
          decoration: BoxDecoration(
            color: selected ? selectedBg : scheme.surfaceContainerLowest,
            border: Border.all(
              color: selected ? scheme.primary : borderColor,
              width: selected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
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
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: ZolyaTypography.subtitle
                                .copyWith(color: scheme.onSurface),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: ZolyaSpacing.sm),
                          badge!,
                        ],
                      ],
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: ZolyaSpacing.xs / 2),
                      Text(
                        subtitle!,
                        style: ZolyaTypography.bodySmall
                            .copyWith(color: mutedColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: ZolyaSpacing.sm + 2),
              trailing ?? _RadioDot(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final inactiveBorder =
        isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? scheme.primary : Colors.transparent,
        border: Border.all(
          color: selected ? scheme.primary : inactiveBorder,
          width: 1.5,
        ),
      ),
      child: selected
          ? Center(
              child: Icon(LucideIcons.check,
                  size: 14, color: scheme.onPrimary),
            )
          : null,
    );
  }
}
