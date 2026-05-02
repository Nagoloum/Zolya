import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaSegment<T> {
  const ZolyaSegment({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}

class ZolyaSegmentedControl<T> extends StatelessWidget {
  const ZolyaSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
  });

  final List<ZolyaSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final bgColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.xs),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: _Segment<T>(
                segment: segment,
                selected: segment.value == value,
                onTap: () => onChanged(segment.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.segment,
    required this.selected,
    required this.onTap,
  });
  final ZolyaSegment<T> segment;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final activeColor = scheme.onSurface;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final activeBg = isLight ? ZolyaColors.surface : ZolyaColors.surfaceDark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.sm + 2),
        decoration: BoxDecoration(
          color: selected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: scheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (segment.icon != null) ...[
              Icon(
                segment.icon,
                size: 16,
                color: selected ? activeColor : mutedColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              segment.label,
              style: ZolyaTypography.bodySmall.copyWith(
                color: selected ? activeColor : mutedColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
