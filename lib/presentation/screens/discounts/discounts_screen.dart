import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/extensions/date_extensions.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/discounts/discounts_cubit.dart';
import '../../bloc/discounts/discounts_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/new_discount_sheet.dart';

class DiscountsScreen extends StatefulWidget {
  const DiscountsScreen({super.key});

  @override
  State<DiscountsScreen> createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiscountsCubit>().load();
  }

  void _openNewSheet() {
    final user = FakeData.currentUser;
    final mine = FakeData.products
        .where((p) => p.sellerId == user.id)
        .toList(growable: false);
    final products = mine.isNotEmpty ? mine : FakeData.products.take(4).toList();
    NewDiscountSheet.show(
      context,
      products: products,
      onSubmit: (productId, percent, endsAt) {
        context.read<DiscountsCubit>().create(
              productId: productId,
              discountPercent: percent,
              endsAt: endsAt,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'My discounts', centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewSheet,
        icon: const Icon(LucideIcons.plus),
        label: const Text('New discount'),
      ),
      body: BlocBuilder<DiscountsCubit, DiscountsState>(
        builder: (context, state) {
          final discounts = state.discounts.isNotEmpty
              ? state.discounts
              : (state.loading ? <DiscountUi>[] : FakeData.myDiscounts());
          return _DiscountsContent(
            discounts: discounts,
            scheme: scheme,
            mutedColor: mutedColor,
            loading: state.loading,
          );
        },
      ),
    );
  }
}

class _DiscountsContent extends StatelessWidget {
  const _DiscountsContent({
    required this.discounts,
    required this.scheme,
    required this.mutedColor,
    required this.loading,
  });

  final List<DiscountUi> discounts;
  final ColorScheme scheme;
  final Color mutedColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading && discounts.isEmpty) {
      return const Center(child: ZolyaSpinner());
    }
    return discounts.isEmpty
          ? const ZolyaEmptyState(
              icon: LucideIcons.tag,
              title: 'No active discount',
              body:
                  'Boost your sales by offering discounts on your articles. '
                  'Touchez « + » pour démarrer.',
            )
          : ListView(
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              children: [
                Container(
                  padding: const EdgeInsets.all(ZolyaSpacing.md),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(ZolyaRadius.md),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LucideIcons.percent,
                          size: 18, color: scheme.primary),
                      const SizedBox(width: ZolyaSpacing.sm),
                      Expanded(
                        child: Text(
                          'Les acheteurs voient un badge promo et reçoivent une notification. '
                          'A successful discount boosts your sale chances by +40%.',
                          style: ZolyaTypography.bodySmall
                              .copyWith(color: mutedColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: ZolyaSpacing.xl),
                for (final d in discounts) ...[
                  _DiscountCard(discount: d),
                  const SizedBox(height: ZolyaSpacing.md),
                ],
                const SizedBox(height: 80),
              ],
            );
  }
}

class _DiscountCard extends StatelessWidget {
  const _DiscountCard({required this.discount});
  final DiscountUi discount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            child: SizedBox(
              width: 64,
              height: 64,
              child: discount.productImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: discount.productImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: placeholderColor),
                      errorWidget: (_, __, ___) => Container(color: placeholderColor),
                    )
                  : Container(color: placeholderColor),
            ),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        discount.productTitle,
                        style: ZolyaTypography.subtitle
                            .copyWith(color: scheme.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: ZolyaSpacing.sm),
                    ZolyaBadge(
                      label: '-${discount.discountPercent}%',
                      variant: ZolyaBadgeVariant.primary,
                    ),
                  ],
                ),
                const SizedBox(height: ZolyaSpacing.xs / 2),
                Row(
                  children: [
                    Text(
                      Formatters.price(discount.discountedPrice),
                      style: ZolyaTypography.subtitle.copyWith(
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Text(
                      Formatters.price(discount.originalPrice),
                      style: ZolyaTypography.bodySmall.copyWith(
                        color: mutedColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ZolyaSpacing.xs),
                Row(
                  children: [
                    Icon(LucideIcons.clock3, size: 12, color: mutedColor),
                    const SizedBox(width: 4),
                    Text(
                      discount.endsAt != null
                          ? 'Expire ${discount.endsAt!.timeAgo.replaceAll("Il y a", "dans")}'
                          : 'No expiration',
                      style: ZolyaTypography.label
                          .copyWith(color: mutedColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(LucideIcons.ellipsisVertical, color: mutedColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
