import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ZolyaStarsRow extends StatelessWidget {
  const ZolyaStarsRow({
    super.key,
    required this.rating,
    this.size = 16,
    this.maxStars = 5,
  });

  final num rating;
  final double size;
  final int maxStars;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filledCount = rating.floor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) {
        final filled = i < filledCount;
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            LucideIcons.star,
            size: size,
            color: filled ? scheme.primary : scheme.outline,
          ),
        );
      }),
    );
  }
}
