import 'package:flutter/material.dart';

import '../../../../theme/zolya_theme.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    super.key,
    required this.title,
    required this.child,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style:
                    ZolyaTypography.subtitle.copyWith(color: scheme.onSurface),
              ),
            ),
            if (actionLabel != null)
              GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionLabel!,
                  style: ZolyaTypography.bodySmall.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: ZolyaSpacing.md),
        child,
      ],
    );
  }
}
