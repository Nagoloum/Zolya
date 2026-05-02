import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class DiscoverSearchBar extends StatelessWidget {
  const DiscoverSearchBar({
    super.key,
    required this.hint,
    required this.onTap,
    required this.onFilterTap,
  });

  final String hint;
  final VoidCallback onTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ZolyaSearchField(hint: hint, onTap: onTap)),
        const SizedBox(width: ZolyaSpacing.sm + 2),
        _FilterButton(onTap: onFilterTap),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: ZolyaGradients.or,
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
        alignment: Alignment.center,
        child: Icon(
          LucideIcons.slidersHorizontal,
          color: scheme.onPrimary,
          size: 20,
        ),
      ),
    );
  }
}
