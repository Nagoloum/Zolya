import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';

class SearchNoResults extends StatelessWidget {
  const SearchNoResults({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final iconColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final bodyColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(ZolyaRadius.full),
              ),
              alignment: Alignment.center,
              child: Icon(LucideIcons.search, size: 36, color: iconColor),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Text(
              title,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            Text(
              body,
              style: ZolyaTypography.body.copyWith(color: bodyColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
