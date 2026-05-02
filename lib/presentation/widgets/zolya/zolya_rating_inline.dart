import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaRatingInline extends StatelessWidget {
  const ZolyaRatingInline({
    super.key,
    required this.rating,
    required this.reviewsCount,
    this.reviewsLabel,
    this.onTap,
  });

  final double rating;
  final int reviewsCount;
  final String? reviewsLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.star, color: scheme.primary, size: 16),
            const SizedBox(width: ZolyaSpacing.xs + 2),
            Text(
              '${rating.toStringAsFixed(1)}/5',
              style: ZolyaTypography.body.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
                decoration: onTap != null ? TextDecoration.underline : null,
              ),
            ),
            const SizedBox(width: ZolyaSpacing.xs + 2),
            Flexible(
              child: Text(
                reviewsLabel != null
                    ? '($reviewsCount $reviewsLabel)'
                    : '($reviewsCount)',
                overflow: TextOverflow.ellipsis,
                style: ZolyaTypography.caption.copyWith(color: mutedColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
