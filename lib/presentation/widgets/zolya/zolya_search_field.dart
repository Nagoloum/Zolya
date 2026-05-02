import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaSearchField extends StatelessWidget {
  const ZolyaSearchField({
    super.key,
    this.controller,
    required this.hint,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.trailing,
  });

  final TextEditingController? controller;
  final String hint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final hintColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    final isReadOnly = onTap != null && controller == null;

    final inner = Row(
      children: [
        Icon(LucideIcons.search, color: mutedColor, size: 20),
        const SizedBox(width: ZolyaSpacing.sm),
        Expanded(
          child: isReadOnly
              ? Text(
                  hint,
                  style: ZolyaTypography.body.copyWith(color: hintColor),
                )
              : TextField(
                  controller: controller,
                  autofocus: autofocus,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
                  cursorColor: scheme.onSurface,
                  decoration: InputDecoration.collapsed(
                    hintText: hint,
                    hintStyle:
                        ZolyaTypography.body.copyWith(color: hintColor),
                  ),
                ),
        ),
        trailing ?? Icon(LucideIcons.mic, color: mutedColor, size: 20),
      ],
    );

    final container = Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: inner,
    );

    if (isReadOnly) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
          child: container,
        ),
      );
    }
    return container;
  }
}
