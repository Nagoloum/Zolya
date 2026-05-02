import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/extensions/date_extensions.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/offer.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/offers/offers_cubit.dart';
import '../../bloc/offers/offers_state.dart';
import '../../widgets/zolya/zolya.dart';

class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({super.key});

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: ZolyaTopBar(
          title: 'My offers',
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: scheme.outline),
                    ),
                  ),
                  child: TabBar(
                    indicatorColor: scheme.primary,
                    labelColor: scheme.primary,
                    unselectedLabelColor: mutedColor,
                    labelStyle: ZolyaTypography.subtitle,
                    unselectedLabelStyle: ZolyaTypography.subtitle,
                    indicatorWeight: 2,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: 'Envoyées (${state.sent.length})'),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Reçues (${state.received.length})'),
                            if (state.pendingReceivedCount > 0) ...[
                              const SizedBox(width: ZolyaSpacing.xs),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: scheme.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            if (state.loading && state.offers.isEmpty) {
              return const Center(child: ZolyaSpinner());
            }
            return TabBarView(
              children: [
                _OfferList(offers: state.sent, direction: OfferDirection.sent),
                _OfferList(
                  offers: state.received,
                  direction: OfferDirection.received,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OfferList extends StatelessWidget {
  const _OfferList({required this.offers, required this.direction});
  final List<Offer> offers;
  final OfferDirection direction;

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return ZolyaEmptyState(
        icon: LucideIcons.tag,
        title: direction == OfferDirection.sent
            ? 'Aucune offre envoyée'
            : 'Aucune offre reçue',
        body: direction == OfferDirection.sent
            ? "On a product page, tap «Make an offer» to suggest your price."
            : 'Les offres reçues sur vos articles apparaîtront ici.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      itemCount: offers.length,
      separatorBuilder: (_, __) => const SizedBox(height: ZolyaSpacing.md),
      itemBuilder: (_, i) => _OfferCard(offer: offers[i]),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer});
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    final isReceived = offer.direction == OfferDirection.received;
    final counterpartName =
        isReceived ? offer.buyerName : offer.sellerName;
    final counterpartAvatar =
        isReceived ? offer.buyerAvatarUrl : offer.sellerAvatarUrl;

    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: offer.productImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: offer.productImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              Container(color: placeholderColor),
                          errorWidget: (_, __, ___) =>
                              Container(color: placeholderColor),
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
                    Text(
                      offer.productTitle,
                      style: ZolyaTypography.subtitle
                          .copyWith(color: scheme.onSurface),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ZolyaAvatar(
                          name: counterpartName,
                          imageUrl: counterpartAvatar,
                          size: ZolyaAvatarSize.sm,
                          diameter: 18,
                          useGradient: false,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            counterpartName,
                            style: ZolyaTypography.bodySmall
                                .copyWith(color: mutedColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: ZolyaSpacing.sm),
                        Text(
                          offer.createdAt.timeAgo,
                          style: ZolyaTypography.label
                              .copyWith(color: mutedColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: offer.status),
            ],
          ),
          const SizedBox(height: ZolyaSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.md,
              vertical: ZolyaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Offre',
                        style: ZolyaTypography.label.copyWith(color: mutedColor),
                      ),
                      Text(
                        Formatters.price(offer.offerAmount),
                        style: ZolyaTypography.title
                            .copyWith(color: scheme.primary),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Prix demandé',
                      style: ZolyaTypography.label.copyWith(color: mutedColor),
                    ),
                    Text(
                      Formatters.price(offer.productPrice),
                      style: ZolyaTypography.bodySmall.copyWith(
                        color: mutedColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: ZolyaSpacing.md),
                _DiscountChip(percent: offer.discountPercent),
              ],
            ),
          ),
          if (offer.message != null) ...[
            const SizedBox(height: ZolyaSpacing.sm),
            Text(
              '« ${offer.message!} »',
              style: ZolyaTypography.bodySmall.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          if (offer.status == OfferStatus.pending) ...[
            const SizedBox(height: ZolyaSpacing.md),
            if (isReceived)
              Row(
                children: [
                  Expanded(
                    child: ZolyaButton(
                      variant: ZolyaButtonVariant.outline,
                      label: 'Decline',
                      onPressed: () => context
                          .read<OffersCubit>()
                          .respond(
                            offerId: offer.id,
                            newStatus: OfferStatus.declined,
                          ),
                      expand: true,
                    ),
                  ),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Expanded(
                    child: ZolyaButton(
                      label: 'Accept',
                      onPressed: () => context
                          .read<OffersCubit>()
                          .respond(
                            offerId: offer.id,
                            newStatus: OfferStatus.accepted,
                          ),
                      expand: true,
                    ),
                  ),
                ],
              )
            else
              ZolyaButton(
                variant: ZolyaButtonVariant.outline,
                label: "Retirer l'offre",
                onPressed: () =>
                    context.read<OffersCubit>().withdraw(offer.id),
                expand: true,
              ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final OfferStatus status;

  @override
  Widget build(BuildContext context) {
    final variant = switch (status) {
      OfferStatus.accepted => ZolyaBadgeVariant.success,
      OfferStatus.declined => ZolyaBadgeVariant.error,
      OfferStatus.expired => ZolyaBadgeVariant.secondary,
      OfferStatus.withdrawn => ZolyaBadgeVariant.secondary,
      OfferStatus.pending => ZolyaBadgeVariant.warning,
    };
    final label = switch (status) {
      OfferStatus.pending => 'Pending',
      OfferStatus.accepted => 'Accepted',
      OfferStatus.declined => 'Declined',
      OfferStatus.expired => 'Expired',
      OfferStatus.withdrawn => 'Withdrawn',
    };
    return ZolyaBadge(label: label, variant: variant);
  }
}

class _DiscountChip extends StatelessWidget {
  const _DiscountChip({required this.percent});
  final int percent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(ZolyaRadius.sm),
      ),
      child: Text(
        '-$percent%',
        style: ZolyaTypography.label.copyWith(color: scheme.onPrimary),
      ),
    );
  }
}
