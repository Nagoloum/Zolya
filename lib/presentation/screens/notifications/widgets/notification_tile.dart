import 'package:flutter/material.dart';

import '../../../../data/fake/ui_models.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

export '../../../../data/fake/ui_models.dart' show NotificationItemData;

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.data});
  final NotificationItemData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final iconBgInactive =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final newBg = scheme.primary.withValues(alpha: 0.08);
    final newBorder = scheme.primary.withValues(alpha: 0.4);
    final newIconBg = scheme.primary.withValues(alpha: 0.15);

    final isNew = data.isNew;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs),
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: isNew ? newBg : scheme.surfaceContainerLowest,
        border: Border.all(
          color: isNew ? newBorder : scheme.outline,
          width: isNew ? 1 : 0.5,
        ),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isNew ? newIconBg : iconBgInactive,
              borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            ),
            alignment: Alignment.center,
            child: Icon(
              data.icon,
              size: 20,
              color: isNew ? scheme.primary : scheme.onSurface,
            ),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.title,
                  style: ZolyaTypography.subtitle
                      .copyWith(color: scheme.onSurface),
                ),
                const SizedBox(height: ZolyaSpacing.xs / 2),
                Text(
                  data.subtitle,
                  style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
          if (isNew) ...[
            const SizedBox(width: ZolyaSpacing.sm),
            const Padding(
              padding: EdgeInsets.only(top: ZolyaSpacing.xs),
              child: ZolyaBadge(label: 'NEW'),
            ),
          ],
        ],
      ),
    );
  }
}
