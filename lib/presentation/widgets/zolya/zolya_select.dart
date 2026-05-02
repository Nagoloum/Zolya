import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaSelectOption<T> {
  const ZolyaSelectOption({required this.value, required this.label});
  final T value;
  final String label;
}

class ZolyaSelect<T> extends StatelessWidget {
  const ZolyaSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder,
    this.label,
    this.itemBuilder,
    this.enabled = true,
  });

  final T? value;
  final List<ZolyaSelectOption<T>> options;
  final ValueChanged<T?> onChanged;
  final String? placeholder;
  final String? label;
  final Widget Function(ZolyaSelectOption<T> option)? itemBuilder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final hintColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final field = Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.md + 2),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(ZolyaRadius.sm),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: scheme.surface,
          hint: placeholder != null
              ? Text(
                  placeholder!,
                  style: ZolyaTypography.body.copyWith(color: hintColor),
                )
              : null,
          icon: Icon(LucideIcons.chevronDown, size: 16, color: mutedColor),
          style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
          onChanged: enabled ? onChanged : null,
          items: [
            for (final opt in options)
              DropdownMenuItem<T>(
                value: opt.value,
                child: itemBuilder != null
                    ? itemBuilder!(opt)
                    : Text(opt.label),
              ),
          ],
        ),
      ),
    );

    if (label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: ZolyaTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: ZolyaSpacing.xs + 2),
        field,
      ],
    );
  }
}
