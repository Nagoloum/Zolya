import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaChip extends StatelessWidget {
  const ZolyaChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.leading,
    this.trailing,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final badge = ShadBadge.raw(
      variant: selected ? ShadBadgeVariant.primary : ShadBadgeVariant.outline,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: ZolyaSpacing.xs + 2),
          ],
          Text(
            label,
            style: ZolyaTypography.bodySmall.copyWith(
              color: selected ? scheme.onPrimary : scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: ZolyaSpacing.xs + 2),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap == null) return badge;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.full),
      child: badge,
    );
  }
}
