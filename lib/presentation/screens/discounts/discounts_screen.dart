import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
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
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.discountsTitle, centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewSheet,
        icon: const Icon(LucideIcons.plus),
        label: Text(l.discountsNewCta),
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
    final l = context.l10n;
    return discounts.isEmpty
          ? ZolyaEmptyState(
              icon: LucideIcons.tag,
              title: l.discountsEmptyTitle,
              body: l.discountsEmptyBody,
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
                          l.discountsInfoBanner,
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
                    Builder(builder: (context) {
                      final l = context.l10n;
                      String label;
                      if (discount.endsAt == null) {
                        label = l.discountsNoExpiration;
                      } else {
                        final remainingMs = discount.endsAt!
                            .difference(DateTime.now())
                            .inMilliseconds;
                        final days = (remainingMs / Duration.millisecondsPerDay)
                            .ceil()
                            .clamp(0, 365);
                        label = days <= 0
                            ? l.discountsExpiresInDays(0)
                            : l.discountsExpiresInDays(days);
                      }
                      return Text(
                        label,
                        style: ZolyaTypography.label
                            .copyWith(color: mutedColor),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Builder(builder: (innerCtx) {
            return IconButton(
              icon: Icon(LucideIcons.ellipsisVertical, color: mutedColor),
              onPressed: () => _showActionMenu(innerCtx),
            );
          }),
        ],
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => _DiscountActionsSheet(
        onEdit: () {
          Navigator.of(sheetCtx).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit coming soon')),
          );
        },
        onCancel: () {
          Navigator.of(sheetCtx).pop();
          context.read<DiscountsCubit>().remove(discount.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Discount cancelled')),
          );
        },
      ),
    );
  }
}

class _DiscountActionsSheet extends StatelessWidget {
  const _DiscountActionsSheet({
    required this.onEdit,
    required this.onCancel,
  });
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor =
        isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final l = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ZolyaRadius.xl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
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
              _ActionRow(
                icon: LucideIcons.pencil,
                label: l.discountActionEdit,
                onTap: onEdit,
                color: scheme.onSurface,
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              _ActionRow(
                icon: LucideIcons.x,
                label: l.discountActionCancel,
                onTap: onCancel,
                color: scheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ZolyaSpacing.md,
            vertical: ZolyaSpacing.md + 2,
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: ZolyaSpacing.md),
              Text(
                label,
                style: ZolyaTypography.body.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
