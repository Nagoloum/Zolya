import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaDivider extends StatelessWidget {
  const ZolyaDivider({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    if (label == null) {
      return Divider(color: scheme.outline, thickness: 1, height: 1);
    }
    return Row(
      children: [
        Expanded(child: Divider(color: scheme.outline, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.md),
          child: Text(
            label!,
            style: ZolyaTypography.caption.copyWith(color: mutedColor),
          ),
        ),
        Expanded(child: Divider(color: scheme.outline, thickness: 1)),
      ],
    );
  }
}
