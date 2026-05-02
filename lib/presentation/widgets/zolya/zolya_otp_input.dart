import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaOtpInput extends StatelessWidget {
  const ZolyaOtpInput({
    super.key,
    required this.length,
    required this.controller,
    this.onCompleted,
    this.autofocus = true,
  });

  final int length;
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final focusedFill = scheme.primary.withValues(alpha: 0.08);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: ZolyaTypography.title
          .copyWith(fontSize: 22, color: scheme.onSurface),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        border: Border.all(color: borderColor),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: focusedFill,
        border: Border.all(color: scheme.primary, width: 2),
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      autofocus: autofocus,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      onCompleted: onCompleted,
    );
  }
}
