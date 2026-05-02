import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../theme/zolya_theme.dart';
import 'zolya_spinner.dart';

enum ZolyaButtonVariant { primary, secondary, outline, ghost, destructive }

enum ZolyaButtonSize { sm, md, lg }

class ZolyaButton extends StatelessWidget {
  const ZolyaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ZolyaButtonVariant.primary,
    this.size = ZolyaButtonSize.md,
    this.leading,
    this.trailing,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final ZolyaButtonVariant variant;
  final ZolyaButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool loading;
  final bool expand;

  ShadButtonSize get _shadSize => switch (size) {
        ZolyaButtonSize.sm => ShadButtonSize.sm,
        ZolyaButtonSize.md => ShadButtonSize.regular,
        ZolyaButtonSize.lg => ShadButtonSize.lg,
      };

  @override
  Widget build(BuildContext context) {
    final disabled = loading || onPressed == null;
    final scheme = Theme.of(context).colorScheme;
    final spinnerColor = switch (variant) {
      ZolyaButtonVariant.primary => scheme.onPrimary,
      ZolyaButtonVariant.destructive => scheme.onError,
      _ => scheme.onSurface,
    };
    final effectiveLeading = loading
        ? ZolyaSpinner(
            size: ZolyaSpinnerSize.sm,
            color: spinnerColor,
          )
        : leading;

    final child = Text(label, style: ZolyaTypography.button);

    final button = switch (variant) {
      ZolyaButtonVariant.primary => ShadButton(
          size: _shadSize,
          onPressed: disabled ? null : onPressed,
          leading: effectiveLeading,
          trailing: trailing,
          width: expand ? double.infinity : null,
          child: child,
        ),
      ZolyaButtonVariant.secondary => ShadButton.secondary(
          size: _shadSize,
          onPressed: disabled ? null : onPressed,
          leading: effectiveLeading,
          trailing: trailing,
          width: expand ? double.infinity : null,
          child: child,
        ),
      ZolyaButtonVariant.outline => ShadButton.outline(
          size: _shadSize,
          onPressed: disabled ? null : onPressed,
          leading: effectiveLeading,
          trailing: trailing,
          width: expand ? double.infinity : null,
          child: child,
        ),
      ZolyaButtonVariant.ghost => ShadButton.ghost(
          size: _shadSize,
          onPressed: disabled ? null : onPressed,
          leading: effectiveLeading,
          trailing: trailing,
          width: expand ? double.infinity : null,
          child: child,
        ),
      ZolyaButtonVariant.destructive => ShadButton.destructive(
          size: _shadSize,
          onPressed: disabled ? null : onPressed,
          leading: effectiveLeading,
          trailing: trailing,
          width: expand ? double.infinity : null,
          child: child,
        ),
    };

    return button;
  }
}
