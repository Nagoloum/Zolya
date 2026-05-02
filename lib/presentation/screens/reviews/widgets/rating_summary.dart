import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({
    super.key,
    required this.average,
    required this.totalRatings,
    required this.breakdown,
    required this.ratingsLabel,
  });

  final double average;
  final int totalRatings;
  final List<int> breakdown;
  final String ratingsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final maxCount = breakdown.fold<int>(1, (a, b) => b > a ? b : a);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              average.toStringAsFixed(1),
              style:
                  ZolyaTypography.displayLarge.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: ZolyaSpacing.xs),
            ZolyaStarsRow(rating: average, size: 18),
            const SizedBox(height: ZolyaSpacing.xs),
            Text(
              '$totalRatings $ratingsLabel',
              style: ZolyaTypography.caption.copyWith(color: mutedColor),
            ),
          ],
        ),
        const SizedBox(width: ZolyaSpacing.xl),
        Expanded(
          child: Column(
            children: List.generate(5, (i) {
              final stars = 5 - i;
              return _BreakdownRow(
                stars: stars,
                count: breakdown[i],
                maxCount: maxCount,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.stars,
    required this.count,
    required this.maxCount,
  });
  final int stars;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ratio = maxCount == 0 ? 0.0 : count / maxCount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(LucideIcons.star, size: 12, color: scheme.primary),
          const SizedBox(width: ZolyaSpacing.xs),
          Text(
            '$stars',
            style: ZolyaTypography.label.copyWith(color: scheme.onSurface),
          ),
          const SizedBox(width: ZolyaSpacing.sm),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Stack(
                children: [
                  Container(height: 6, color: scheme.surfaceContainerHighest),
                  FractionallySizedBox(
                    widthFactor: ratio,
                    child: Container(height: 6, color: scheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
