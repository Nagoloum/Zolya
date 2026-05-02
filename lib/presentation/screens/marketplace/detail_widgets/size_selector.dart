import 'package:flutter/material.dart';

import '../../../../theme/zolya_theme.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
  });

  final List<String> sizes;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: ZolyaSpacing.sm + 2,
      runSpacing: ZolyaSpacing.sm + 2,
      children: sizes.map((s) {
        final isSelected = s == selected;
        return GestureDetector(
          onTap: () => onSelected(s),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            width: 54,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? scheme.primary
                  : scheme.surfaceContainerLowest,
              border: Border.all(
                color: isSelected ? scheme.primary : scheme.outline,
              ),
              borderRadius: BorderRadius.circular(ZolyaRadius.md),
            ),
            child: Text(
              s,
              style: ZolyaTypography.body.copyWith(
                color: isSelected ? scheme.onPrimary : scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
