import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaSwitch extends StatelessWidget {
  const ZolyaSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final inactiveTrack =
        isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    final sw = Switch.adaptive(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeThumbColor: scheme.onPrimary,
      activeTrackColor: scheme.primary,
      inactiveThumbColor: scheme.surface,
      inactiveTrackColor: inactiveTrack,
    );

    if (label == null && description == null) return sw;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: ZolyaTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: enabled ? scheme.onSurface : mutedColor,
                  ),
                ),
              if (description != null) ...[
                const SizedBox(height: ZolyaSpacing.xs / 2),
                Text(
                  description!,
                  style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: ZolyaSpacing.md),
        sw,
      ],
    );
  }
}
