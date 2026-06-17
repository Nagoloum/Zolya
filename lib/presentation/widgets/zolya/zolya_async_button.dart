import 'package:flutter/material.dart';

import 'zolya_button.dart';

/// Variante de [ZolyaButton] pour les actions **asynchrones**.
///
/// Encapsule le pattern récurrent « chargement + bouton grisé anti double-clic » :
/// au clic, le bouton passe en `loading`, devient non cliquable, attend la fin
/// du [Future] retourné par [onPressed], puis se réactive (via `try/finally`,
/// même en cas d'erreur). Un second clic pendant l'exécution est ignoré.
///
/// Exemple :
/// ```dart
/// ZolyaAsyncButton(
///   label: l.checkoutPlaceOrder,
///   onPressed: () => cubit.placeOrder(),
///   expand: true,
///   size: ZolyaButtonSize.lg,
/// )
/// ```
///
/// Pour désactiver le bouton sans le faire tourner (ex. formulaire invalide),
/// passer [enabled] à `false` ou [onPressed] à `null`.
class ZolyaAsyncButton extends StatefulWidget {
  const ZolyaAsyncButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ZolyaButtonVariant.primary,
    this.size = ZolyaButtonSize.md,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.expand = false,
  });

  final String label;

  /// Action asynchrone exécutée au clic. Le bouton reste en chargement tant
  /// que le [Future] n'est pas résolu. `null` => bouton désactivé.
  final Future<void> Function()? onPressed;

  final ZolyaButtonVariant variant;
  final ZolyaButtonSize size;
  final Widget? leading;
  final Widget? trailing;

  /// Désactive le bouton sans déclencher l'état de chargement.
  final bool enabled;
  final bool expand;

  @override
  State<ZolyaAsyncButton> createState() => _ZolyaAsyncButtonState();
}

class _ZolyaAsyncButtonState extends State<ZolyaAsyncButton> {
  bool _running = false;

  Future<void> _handlePressed() async {
    final action = widget.onPressed;
    if (_running || action == null) return;
    setState(() => _running = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = !widget.enabled || widget.onPressed == null;
    return ZolyaButton(
      label: widget.label,
      onPressed: (disabled || _running) ? null : _handlePressed,
      loading: _running,
      variant: widget.variant,
      size: widget.size,
      leading: widget.leading,
      trailing: widget.trailing,
      expand: widget.expand,
    );
  }
}
