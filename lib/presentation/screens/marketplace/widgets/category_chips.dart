import 'package:flutter/material.dart';

import '../../../../theme/zolya_theme.dart';

class CategoryOption {
  const CategoryOption({required this.id, required this.label});
  final String id;
  final String label;
}

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<CategoryOption> categories;
  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg),
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: ZolyaSpacing.sm + 2),
        itemBuilder: (_, index) {
          final cat = categories[index];
          final selected = cat.id == selectedId;
          return _CategoryChip(
            label: cat.label,
            selected: selected,
            onTap: () => onSelected(cat.id),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.lg + 2,
          vertical: ZolyaSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(ZolyaRadius.full),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
          ),
        ),
        child: Text(
          label,
          style: ZolyaTypography.bodySmall.copyWith(
            color: selected ? scheme.onPrimary : scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
