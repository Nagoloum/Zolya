import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';
import 'zolya_button.dart';

class ZolyaConfirmDialog extends StatelessWidget {
  const ZolyaConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.icon,
    this.iconColor,
    this.destructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData? icon;
  final Color? iconColor;
  final bool destructive;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    IconData? icon,
    Color? iconColor,
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ZolyaConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        icon: icon,
        iconColor: iconColor,
        destructive: destructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final accent = iconColor ?? (destructive ? scheme.error : scheme.primary);

    return Dialog(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZolyaRadius.lg),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.xxl,
        vertical: ZolyaSpacing.xl,
      ),
      child: Padding(
        padding: const EdgeInsets.all(ZolyaSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (icon != null)
              Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: accent, size: 28),
                ),
              ),
            if (icon != null) const SizedBox(height: ZolyaSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: ZolyaTypography.body.copyWith(color: mutedColor),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: ZolyaButton(
                    variant: ZolyaButtonVariant.outline,
                    label: cancelLabel,
                    onPressed: () => Navigator.of(context).pop(false),
                    expand: true,
                  ),
                ),
                const SizedBox(width: ZolyaSpacing.sm),
                Expanded(
                  child: ZolyaButton(
                    variant: destructive
                        ? ZolyaButtonVariant.destructive
                        : ZolyaButtonVariant.primary,
                    label: confirmLabel,
                    onPressed: () => Navigator.of(context).pop(true),
                    expand: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
