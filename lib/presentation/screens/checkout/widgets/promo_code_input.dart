import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class PromoCodeInput extends StatelessWidget {
  const PromoCodeInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.addLabel,
    required this.onAdd,
  });

  final TextEditingController controller;
  final String hint;
  final String addLabel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final hintColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.md),
            decoration: BoxDecoration(
              color: fillColor,
              border: Border.all(color: scheme.outline),
              borderRadius: BorderRadius.circular(ZolyaRadius.md),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.tag, size: 16, color: mutedColor),
                const SizedBox(width: ZolyaSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style:
                        ZolyaTypography.body.copyWith(color: scheme.onSurface),
                    cursorColor: scheme.primary,
                    decoration: InputDecoration.collapsed(
                      hintText: hint,
                      hintStyle:
                          ZolyaTypography.body.copyWith(color: hintColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: ZolyaSpacing.sm + 2),
        ZolyaButton(
          variant: ZolyaButtonVariant.secondary,
          label: addLabel,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
