import 'package:flutter/material.dart';

import '../../../../data/fake/ui_models.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/common/momo_logo.dart';

enum CheckoutPaymentKind { mtn, orange }

class PaymentChips extends StatelessWidget {
  const PaymentChips({
    super.key,
    required this.selected,
    required this.mtnLabel,
    required this.orangeLabel,
    required this.onChanged,
  });

  final CheckoutPaymentKind selected;
  final String mtnLabel;
  final String orangeLabel;
  final ValueChanged<CheckoutPaymentKind> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Chip(
            provider: MomoProvider.mtn,
            label: mtnLabel,
            selected: selected == CheckoutPaymentKind.mtn,
            onTap: () => onChanged(CheckoutPaymentKind.mtn),
          ),
        ),
        const SizedBox(width: ZolyaSpacing.sm + 2),
        Expanded(
          child: _Chip(
            provider: MomoProvider.orange,
            label: orangeLabel,
            selected: selected == CheckoutPaymentKind.orange,
            onTap: () => onChanged(CheckoutPaymentKind.orange),
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.provider,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final MomoProvider provider;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selectedBg = scheme.primary.withValues(alpha: 0.08);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          vertical: ZolyaSpacing.md,
          horizontal: ZolyaSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? selectedBg : scheme.surfaceContainerLowest,
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: scheme.outline, width: 0.5),
              ),
              child: MomoLogo(provider: provider, width: 32, height: 20),
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: ZolyaTypography.bodySmall.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
