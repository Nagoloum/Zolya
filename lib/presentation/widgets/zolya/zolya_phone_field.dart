import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/utils/phone_formatter.dart';
import '../../../core/utils/validators.dart';
import '../../../theme/zolya_theme.dart';
import 'zolya_text_field.dart';

class ZolyaPhoneField extends StatelessWidget {
  const ZolyaPhoneField({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
  });

  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ZolyaTextField(
      label: label,
      placeholder: placeholder,
      controller: controller,
      validator: validator ?? Validators.phone,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      inputFormatters: [CameroonPhoneFormatter()],
      leading: const _PhonePrefix(),
    );
  }
}

class _PhonePrefix extends StatelessWidget {
  const _PhonePrefix();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Padding(
      padding: const EdgeInsets.only(right: ZolyaSpacing.sm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.phone, size: 16, color: mutedColor),
          const SizedBox(width: ZolyaSpacing.sm),
          Text(
            '+237',
            style: ZolyaTypography.body.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: ZolyaSpacing.xs + 2),
          Container(width: 1, height: 16, color: scheme.outline),
        ],
      ),
    );
  }
}
