import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../zolya/zolya.dart';
import 'package:zolya/theme/zolya_theme.dart';

enum SortOption { relevance, priceLowHigh, priceHighLow }

class ProductFilters {
  const ProductFilters({
    this.sort = SortOption.relevance,
    this.priceRange = const RangeValues(0, 50000),
    this.priceMin,
    this.priceMax,
    this.size,
  });

  final SortOption sort;
  final RangeValues priceRange;
  final int? priceMin;
  final int? priceMax;
  final String? size;

  ProductFilters copyWith({
    SortOption? sort,
    RangeValues? priceRange,
    String? size,
    bool clearSize = false,
  }) {
    return ProductFilters(
      sort: sort ?? this.sort,
      priceRange: priceRange ?? this.priceRange,
      size: clearSize ? null : (size ?? this.size),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, required this.initial});
  final ProductFilters initial;

  static Future<ProductFilters?> show(
    BuildContext context, {
    required ProductFilters initial,
  }) {
    return showModalBottomSheet<ProductFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(initial: initial),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SortOption _sort;
  late RangeValues _price;
  String? _size;

  static const _minPrice = 0.0;
  static const _maxPrice = 50000.0;
  static const _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    _sort = widget.initial.sort;
    _price = widget.initial.priceRange;
    _size = widget.initial.size;
  }

  void _apply() {
    Navigator.of(context).pop(
      ProductFilters(sort: _sort, priceRange: _price, size: _size),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    final sortLabels = {
      SortOption.relevance: l.filterSortRelevance,
      SortOption.priceLowHigh: l.filterSortPriceLowHigh,
      SortOption.priceHighLow: l.filterSortPriceHighLow,
    };

    return Container(
      decoration: const BoxDecoration(
        color: ZolyaColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _DragHandle(),
              const SizedBox(height: ZolyaSpacing.md),
              _Header(
                title: l.filtersTitle,
                onClose: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              _SectionTitle(l.filterSortBy),
              const SizedBox(height: ZolyaSpacing.md),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sortLabels.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, index) {
                    final entry = sortLabels.entries.elementAt(index);
                    return ZolyaChip(
                      label: entry.value,
                      selected: entry.key == _sort,
                      onTap: () => setState(() => _sort = entry.key),
                    );
                  },
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              _PriceSection(
                title: l.filterPrice,
                values: _price,
                min: _minPrice,
                max: _maxPrice,
                onChanged: (v) => setState(() => _price = v),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              _SizeSection(
                title: l.filterSize,
                sizes: _sizes,
                selected: _size,
                onChanged: (v) => setState(() => _size = v),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: l.filterApply,
                onPressed: _apply,
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

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onClose});
  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: ZolyaTypography.headline)),
        InkWell(
          onTap: onClose,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(LucideIcons.x,
                size: 20, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: ZolyaTypography.subtitle);
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({
    required this.title,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
  });
  final String title;
  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  String _format(double v) => '\$ ${v.toInt()}';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: ZolyaTypography.subtitle)),
            Text(
              '${_format(values.start)} - ${_format(values.end)}',
              style: ZolyaTypography.caption.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.65)),
            ),
          ],
        ),
        ZolyaRangeSlider(
          values: values,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SizeSection extends StatelessWidget {
  const _SizeSection({
    required this.title,
    required this.sizes,
    required this.selected,
    required this.onChanged,
  });
  final String title;
  final List<String> sizes;
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: ZolyaTypography.subtitle)),
        SizedBox(
          width: 120,
          child: ZolyaSelect<String?>(
            value: selected,
            placeholder: '—',
            options: [
              const ZolyaSelectOption<String?>(value: null, label: '—'),
              for (final s in sizes) ZolyaSelectOption(value: s, label: s),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
