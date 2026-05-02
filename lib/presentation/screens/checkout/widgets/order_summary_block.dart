import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../theme/zolya_theme.dart';

class OrderSummaryBlock extends StatelessWidget {
  const OrderSummaryBlock({
    super.key,
    required this.subtotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
    required this.subtotalLabel,
    required this.vatLabel,
    required this.shippingLabel,
    required this.totalLabel,
  });

  final int subtotal;
  final int vat;
  final int shippingFee;
  final int total;
  final String subtotalLabel;
  final String vatLabel;
  final String shippingLabel;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Row(label: subtotalLabel, value: Formatters.price(subtotal)),
        _Row(label: vatLabel, value: Formatters.price(vat)),
        _Row(label: shippingLabel, value: Formatters.price(shippingFee)),
        Divider(color: Theme.of(context).colorScheme.outline, height: 24),
        _Row(
          label: totalLabel,
          value: Formatters.price(total),
          bold: true,
          highlight: true,
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.bold = false,
    this.highlight = false,
  });
  final String label;
  final String value;
  final bool bold;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final labelStyle = bold
        ? ZolyaTypography.subtitle.copyWith(color: scheme.onSurface)
        : ZolyaTypography.body.copyWith(color: mutedColor);
    final valueStyle = highlight
        ? ZolyaTypography.title.copyWith(color: scheme.primary)
        : (bold
            ? ZolyaTypography.subtitle.copyWith(color: scheme.onSurface)
            : ZolyaTypography.body.copyWith(color: scheme.onSurface));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs + 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
