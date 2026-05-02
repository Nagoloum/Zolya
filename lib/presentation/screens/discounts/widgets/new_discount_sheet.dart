import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/product.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

class NewDiscountSheet extends StatefulWidget {
  const NewDiscountSheet({
    super.key,
    required this.products,
    required this.onSubmit,
  });

  final List<Product> products;
  final void Function(String productId, int discountPercent, DateTime? endsAt)
      onSubmit;

  static Future<void> show(
    BuildContext context, {
    required List<Product> products,
    required void Function(String productId, int discountPercent, DateTime? endsAt)
        onSubmit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: NewDiscountSheet(products: products, onSubmit: onSubmit),
      ),
    );
  }

  @override
  State<NewDiscountSheet> createState() => _NewDiscountSheetState();
}

class _NewDiscountSheetState extends State<NewDiscountSheet> {
  Product? _selected;
  int _percent = 10;
  int _durationDays = 7;

  @override
  void initState() {
    super.initState();
    _selected = widget.products.isNotEmpty ? widget.products.first : null;
  }

  void _submit() {
    if (_selected == null) return;
    widget.onSubmit(
      _selected!.id,
      _percent,
      DateTime.now().add(Duration(days: _durationDays)),
    );
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    final product = _selected;
    final discountedPrice = product != null
        ? (product.price * (1 - _percent / 100)).round()
        : 0;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ZolyaRadius.xl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            ZolyaSpacing.lg,
            ZolyaSpacing.md,
            ZolyaSpacing.lg,
            ZolyaSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: ZolyaSpacing.lg),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(
                'New discount',
                style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ZolyaSpacing.xs),
              Text(
                'Pick an article then the discount percentage',
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Text(
                'ARTICLE',
                style: ZolyaTypography.label.copyWith(
                  color: mutedColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              if (widget.products.isEmpty)
                Container(
                  padding: const EdgeInsets.all(ZolyaSpacing.md),
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(ZolyaRadius.md),
                  ),
                  child: Text(
                    'You must publish an article first to create a discount.',
                    style: ZolyaTypography.body.copyWith(color: mutedColor),
                  ),
                )
              else
                SizedBox(
                  height: 92,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.products.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: ZolyaSpacing.sm),
                    itemBuilder: (_, i) {
                      final p = widget.products[i];
                      final selected = p.id == _selected?.id;
                      return _ProductChip(
                        product: p,
                        selected: selected,
                        onTap: () => setState(() => _selected = p),
                      );
                    },
                  ),
                ),
              const SizedBox(height: ZolyaSpacing.xl),
              Text(
                'PERCENTAGE',
                style: ZolyaTypography.label.copyWith(
                  color: mutedColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_percent %',
                    style: ZolyaTypography.displayMedium.copyWith(
                      color: scheme.primary,
                      fontSize: 32,
                    ),
                  ),
                  if (product != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.price(discountedPrice),
                          style: ZolyaTypography.subtitle
                              .copyWith(color: scheme.onSurface),
                        ),
                        Text(
                          Formatters.price(product.price),
                          style: ZolyaTypography.bodySmall.copyWith(
                            color: mutedColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: scheme.primary,
                  inactiveTrackColor: borderColor,
                  thumbColor: scheme.primary,
                ),
                child: Slider(
                  value: _percent.toDouble(),
                  min: 5,
                  max: 70,
                  divisions: 13,
                  label: '$_percent %',
                  onChanged: (v) =>
                      setState(() => _percent = (v / 5).round() * 5),
                ),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Text(
                'DURATION',
                style: ZolyaTypography.label.copyWith(
                  color: mutedColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              Wrap(
                spacing: ZolyaSpacing.sm,
                children: [
                  for (final days in const [3, 7, 14, 30])
                    _DurationChip(
                      days: days,
                      selected: _durationDays == days,
                      onTap: () => setState(() => _durationDays = days),
                    ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: 'Activate discount',
                onPressed: product != null ? _submit : null,
                expand: true,
                size: ZolyaButtonSize.lg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductChip extends StatelessWidget {
  const _ProductChip({
    required this.product,
    required this.selected,
    required this.onTap,
  });

  final Product product;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 200,
          padding: const EdgeInsets.all(ZolyaSpacing.sm),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.08)
                : scheme.surfaceContainerLowest,
            border: Border.all(
              color: selected ? scheme.primary : borderColor,
              width: selected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: product.imageUrls.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrls.first,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: fillColor),
                          errorWidget: (_, __, ___) => Container(color: fillColor),
                        )
                      : Container(color: fillColor),
                ),
              ),
              const SizedBox(width: ZolyaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.title,
                      style: ZolyaTypography.bodySmall
                          .copyWith(color: scheme.onSurface),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Formatters.price(product.price),
                      style: ZolyaTypography.label.copyWith(color: mutedColor),
                    ),
                  ],
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 4),
                Icon(LucideIcons.check, size: 16, color: scheme.primary),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.days,
    required this.selected,
    required this.onTap,
  });
  final int days;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.lg,
          vertical: ZolyaSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(ZolyaRadius.full),
          border: Border.all(
            color: selected ? scheme.primary : borderColor,
          ),
        ),
        child: Text(
          '$days jours',
          style: ZolyaTypography.bodySmall.copyWith(
            color: selected ? scheme.onPrimary : scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
