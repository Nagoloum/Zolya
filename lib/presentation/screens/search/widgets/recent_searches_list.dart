import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';

class RecentSearchesList extends StatelessWidget {
  const RecentSearchesList({
    super.key,
    required this.recents,
    required this.title,
    required this.clearAllLabel,
    required this.onClearAll,
    required this.onTap,
    required this.onRemove,
  });

  final List<String> recents;
  final String title;
  final String clearAllLabel;
  final VoidCallback onClearAll;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (recents.isEmpty) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: ZolyaSpacing.xs),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
                ),
              ),
              GestureDetector(
                onTap: onClearAll,
                child: Text(
                  clearAllLabel,
                  style: ZolyaTypography.bodySmall.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (var i = 0; i < recents.length; i++)
          _RecentRow(
            label: recents[i],
            onTap: () => onTap(recents[i]),
            onRemove: () => onRemove(recents[i]),
          ),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({
    required this.label,
    required this.onTap,
    required this.onRemove,
  });
  final String label;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final faint = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.md),
        child: Row(
          children: [
            Icon(LucideIcons.search, size: 16, color: faint),
            const SizedBox(width: ZolyaSpacing.md),
            Expanded(
              child: Text(
                label,
                style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
              ),
            ),
            InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(ZolyaSpacing.xs),
                child: Icon(LucideIcons.x, size: 16, color: faint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
