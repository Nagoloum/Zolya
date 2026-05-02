import 'package:flutter/material.dart';

import '../../../../theme/zolya_theme.dart';

class CategoryGridItem {
  const CategoryGridItem({
    required this.id,
    required this.label,
    required this.icon,
  });
  final String id;
  final String label;
  final IconData icon;
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelected,
  });

  final List<CategoryGridItem> items;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, index) {
        final item = items[index];
        final selected = item.id == selectedId;
        return _Cell(
          item: item,
          selected: selected,
          onTap: () => onSelected(item.id),
        );
      },
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.item,
    required this.selected,
    required this.onTap,
  });
  final CategoryGridItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final inactiveBg =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: selected ? scheme.primary : inactiveBg,
                  borderRadius: BorderRadius.circular(ZolyaRadius.md),
                  border: Border.all(
                    color: selected ? scheme.primary : scheme.outline,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  color: selected ? scheme.onPrimary : scheme.onSurface,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: ZolyaSpacing.sm),
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: ZolyaTypography.caption.copyWith(
              color: scheme.onSurface,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
