import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaCheckbox extends StatelessWidget {
  const ZolyaCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool enabled;

  void _toggle() {
    if (!enabled) return;
    onChanged?.call(!value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final inactiveBorder =
        isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: value ? scheme.primary : Colors.transparent,
        border: Border.all(
          color: value ? scheme.primary : inactiveBorder,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(ZolyaSpacing.xs + 2),
      ),
      child: value
          ? Icon(LucideIcons.check, size: 14, color: scheme.onPrimary)
          : null,
    );

    if (label == null) {
      return GestureDetector(onTap: _toggle, child: box);
    }
    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(ZolyaRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            box,
            const SizedBox(width: ZolyaSpacing.sm + 2),
            Flexible(
              child: Text(
                label!,
                style: ZolyaTypography.body.copyWith(
                  color: enabled ? scheme.onSurface : mutedColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
