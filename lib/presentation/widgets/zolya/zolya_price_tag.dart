import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../theme/zolya_theme.dart';

enum ZolyaPriceTagSize { sm, md, lg }

class ZolyaPriceTag extends StatelessWidget {
  const ZolyaPriceTag({
    super.key,
    required this.amount,
    this.label,
    this.size = ZolyaPriceTagSize.md,
    this.color,
  });

  final num amount;
  final String? label;
  final ZolyaPriceTagSize size;

  final Color? color;

  TextStyle _amountStyle(BuildContext context) {
    final base = switch (size) {
      ZolyaPriceTagSize.sm => ZolyaTypography.subtitle,
      ZolyaPriceTagSize.md => ZolyaTypography.title,
      ZolyaPriceTagSize.lg => ZolyaTypography.headline,
    };
    return base.copyWith(color: color ?? Theme.of(context).colorScheme.primary);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final labelColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final priceText = Formatters.price(amount.toInt());
    final amountStyle = _amountStyle(context);

    if (label == null) {
      return Text(priceText, style: amountStyle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: ZolyaTypography.caption.copyWith(color: labelColor),
        ),
        const SizedBox(height: ZolyaSpacing.xs / 2),
        Text(priceText, style: amountStyle, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
