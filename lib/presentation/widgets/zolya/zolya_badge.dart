import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

enum ZolyaBadgeVariant { primary, secondary, outline, success, warning, error }

class ZolyaBadge extends StatelessWidget {
  const ZolyaBadge({
    super.key,
    required this.label,
    this.variant = ZolyaBadgeVariant.primary,
    this.leading,
  });

  final String label;
  final ZolyaBadgeVariant variant;
  final Widget? leading;

  ({Color bg, Color fg, Color? border}) _colors(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final neutralBg = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return switch (variant) {
      ZolyaBadgeVariant.primary => (
          bg: scheme.primaryContainer,
          fg: scheme.onPrimaryContainer,
          border: null,
        ),
      ZolyaBadgeVariant.secondary => (
          bg: neutralBg,
          fg: scheme.onSurface,
          border: null,
        ),
      ZolyaBadgeVariant.outline => (
          bg: Colors.transparent,
          fg: scheme.primary,
          border: scheme.primary,
        ),
      ZolyaBadgeVariant.success => (
          bg: isLight ? ZolyaColors.succesBg : ZolyaColors.succes.withValues(alpha: 0.18),
          fg: ZolyaColors.succes,
          border: null,
        ),
      ZolyaBadgeVariant.warning => (
          bg: isLight ? ZolyaColors.avertissementBg : ZolyaColors.avertissement.withValues(alpha: 0.18),
          fg: ZolyaColors.avertissement,
          border: null,
        ),
      ZolyaBadgeVariant.error => (
          bg: isLight ? ZolyaColors.erreurBg : ZolyaColors.erreur.withValues(alpha: 0.18),
          fg: scheme.error,
          border: null,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final c = _colors(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.sm, vertical: 3),
      decoration: BoxDecoration(
        color: c.bg,
        borderRadius: BorderRadius.circular(ZolyaRadius.full),
        border: c.border != null ? Border.all(color: c.border!, width: 1) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: c.fg, size: 12),
              child: leading!,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: ZolyaTypography.label.copyWith(color: c.fg),
          ),
        ],
      ),
    );
  }
}
