import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';
import 'zolya_button.dart';

class ZolyaSuccessDialog extends StatelessWidget {
  const ZolyaSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onConfirm;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    required String buttonLabel,
    required VoidCallback onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (_) => ZolyaSuccessDialog(
        title: title,
        message: message,
        buttonLabel: buttonLabel,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Dialog(
      backgroundColor: scheme.surface,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.xxl,
        vertical: ZolyaSpacing.xl,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZolyaRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          ZolyaSpacing.xl,
          ZolyaSpacing.xl + 4,
          ZolyaSpacing.xl,
          ZolyaSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _SuccessCheck()
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 350.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 250.ms),
            const SizedBox(height: ZolyaSpacing.xl),
            Text(
              title,
              style: ZolyaTypography.title
                  .copyWith(fontSize: 20, color: scheme.onSurface),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 150.ms, duration: 250.ms),
            const SizedBox(height: ZolyaSpacing.sm),
            Text(
              message,
              style: ZolyaTypography.body.copyWith(color: mutedColor),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 220.ms, duration: 250.ms),
            const SizedBox(height: ZolyaSpacing.xl),
            ZolyaButton(
              label: buttonLabel,
              onPressed: onConfirm,
              expand: true,
              size: ZolyaButtonSize.lg,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessCheck extends StatelessWidget {
  const _SuccessCheck();

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final ringColor = isLight
        ? ZolyaColors.succesBg
        : ZolyaColors.succes.withValues(alpha: 0.18);

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: ringColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: ZolyaColors.succes,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(LucideIcons.check, color: Colors.white, size: 28),
      ),
    );
  }
}
