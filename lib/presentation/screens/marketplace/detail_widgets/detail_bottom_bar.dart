import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class DetailBottomBar extends StatelessWidget {
  const DetailBottomBar({
    super.key,
    required this.price,
    required this.priceLabel,
    required this.ctaLabel,
    required this.onPressed,
  });

  final int price;
  final String priceLabel;
  final String ctaLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outline)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.lg,
          vertical: ZolyaSpacing.md + 2,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ZolyaPriceTag(
                amount: price,
                label: priceLabel,
                size: ZolyaPriceTagSize.md,
              ),
            ),
            const SizedBox(width: ZolyaSpacing.md),
            Expanded(
              flex: 3,
              child: ZolyaButton(
                label: ctaLabel,
                leading: const Icon(LucideIcons.shoppingBag, size: 18),
                onPressed: onPressed,
                size: ZolyaButtonSize.lg,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
