import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/entities/product.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../bloc/follow/follow_cubit.dart';
import '../../widgets/zolya/zolya.dart';
import '../reviews/widgets/rating_summary.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key, required this.sellerId});
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final seller = FakeData.sellerFor(sellerId);
    final products = FakeData.productsBySeller(sellerId);
    final reviews = FakeData.sellerReviews(sellerId);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: ZolyaTopBar(
          title: seller.fullName,
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Partager',
              icon: Icon(LucideIcons.share2,
                  color: theme.colorScheme.onSurface),
              onPressed: () => ZolyaShareSheet.show(
                context,
                title: seller.fullName,
                shareUrl: 'https://zolya.app/seller/${seller.id}',
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            _SellerHeader(seller: seller).animate().fadeIn(duration: 250.ms),
            const _SellerTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _ListingsTab(products: products),
                  _ReviewsTab(seller: seller, reviews: reviews),
                  _AboutTab(seller: seller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SellerHeader extends StatelessWidget {
  const _SellerHeader({required this.seller});
  final SellerProfileUi seller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.lg,
        vertical: ZolyaSpacing.lg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ZolyaAvatar(
                name: seller.fullName,
                imageUrl: seller.avatarUrl,
                size: ZolyaAvatarSize.lg,
              ),
              const SizedBox(width: ZolyaSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            seller.fullName,
                            style: ZolyaTypography.headline
                                .copyWith(color: scheme.onSurface),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (seller.isVerified) ...[
                          const SizedBox(width: ZolyaSpacing.xs),
                          Icon(LucideIcons.badgeCheck,
                              size: 18, color: scheme.primary),
                        ],
                      ],
                    ),
                    const SizedBox(height: ZolyaSpacing.xs / 2),
                    Row(
                      children: [
                        Icon(LucideIcons.star,
                            size: 14, color: scheme.primary),
                        const SizedBox(width: ZolyaSpacing.xs),
                        Text(
                          '${seller.averageRating.toStringAsFixed(1)} '
                          '(${seller.totalReviews} reviews)',
                          style: ZolyaTypography.bodySmall
                              .copyWith(color: mutedColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: ZolyaSpacing.xs / 2),
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: 14, color: mutedColor),
                        const SizedBox(width: ZolyaSpacing.xs),
                        Text(
                          seller.city,
                          style: ZolyaTypography.bodySmall
                              .copyWith(color: mutedColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ZolyaSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '${seller.totalListings}',
                  label: 'Articles',
                  mutedColor: mutedColor,
                ),
              ),
              _StatDivider(),
              Expanded(
                child: _Stat(
                  value: '${seller.totalSales}',
                  label: 'Sales',
                  mutedColor: mutedColor,
                ),
              ),
              _StatDivider(),
              Expanded(
                child: _Stat(
                  value: '${seller.followersCount}',
                  label: 'Followers',
                  mutedColor: mutedColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: ZolyaSpacing.lg),
          BlocBuilder<FollowCubit, FollowState>(
            builder: (context, state) {
              final following = state.isFollowing(seller.id);
              return Row(
                children: [
                  Expanded(
                    child: ZolyaButton(
                      variant: following
                          ? ZolyaButtonVariant.secondary
                          : ZolyaButtonVariant.primary,
                      label: following ? 'Following' : 'Follow',
                      leading: Icon(
                        following ? LucideIcons.userCheck : LucideIcons.userPlus,
                        size: 16,
                      ),
                      onPressed: () =>
                          context.read<FollowCubit>().toggle(seller.id),
                      expand: true,
                    ),
                  ),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Expanded(
                    child: ZolyaButton(
                      variant: ZolyaButtonVariant.outline,
                      label: 'Message',
                      leading: const Icon(LucideIcons.messageCircle, size: 16),
                      onPressed: () {},
                      expand: true,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    return Container(width: 1, height: 32, color: borderColor);
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.value,
    required this.label,
    required this.mutedColor,
  });
  final String value;
  final String label;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: ZolyaTypography.headline.copyWith(
            color: scheme.onSurface,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ZolyaTypography.label.copyWith(color: mutedColor),
        ),
      ],
    );
  }
}

class _SellerTabBar extends StatelessWidget {
  const _SellerTabBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
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
        tabs: const [
          Tab(text: 'Listings'),
          Tab(text: 'Reviews'),
          Tab(text: 'About'),
        ],
      ),
    );
  }
}

class _ListingsTab extends StatelessWidget {
  const _ListingsTab({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const ZolyaEmptyState(
        icon: LucideIcons.shoppingBag,
        title: 'Aucun article publié',
        body: 'Ce vendeur n\'a pas encore publié d\'articles.',
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ZolyaSpacing.lg,
        crossAxisSpacing: ZolyaSpacing.md + 2,
        childAspectRatio: 0.62,
      ),
      itemCount: products.length,
      itemBuilder: (_, i) {
        final p = products[i];
        return BlocSelector<FavoritesCubit, FavoritesState, bool>(
          selector: (s) => s.isFavorite(p.id),
          builder: (context, isFav) => ZolyaProductCard(
            title: p.title,
            priceLabel: Formatters.price(p.price),
            imageUrl: p.mainImageUrl,
            subtitle: p.brand,
            favorite: isFav,
            onTap: () => context.push(RouteNames.productDetailPath(p.id)),
            onToggleFavorite: () =>
                context.read<FavoritesCubit>().toggle(p.id),
          ),
        );
      },
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({required this.seller, required this.reviews});
  final SellerProfileUi seller;
  final List<ReviewItemData> reviews;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return ListView(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      children: [
        RatingSummary(
          average: seller.averageRating,
          totalRatings: seller.totalReviews,
          breakdown: seller.ratingBreakdown,
          ratingsLabel: 'reviews',
        ),
        const SizedBox(height: ZolyaSpacing.xl),
        Divider(color: borderColor, height: 1),
        const SizedBox(height: ZolyaSpacing.lg),
        for (final r in reviews) ...[
          _ReviewCard(review: r, mutedColor: mutedColor, scheme: scheme),
          const SizedBox(height: ZolyaSpacing.md),
        ],
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.review,
    required this.mutedColor,
    required this.scheme,
  });
  final ReviewItemData review;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ZolyaAvatar(
              name: review.author,
              size: ZolyaAvatarSize.sm,
              useGradient: false,
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    review.author,
                    style: ZolyaTypography.bodySmall.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    review.timeAgo,
                    style: ZolyaTypography.label.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
            ZolyaStarsRow(rating: review.rating, size: 14),
          ],
        ),
        const SizedBox(height: ZolyaSpacing.sm),
        Text(
          review.comment,
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ),
      ],
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab({required this.seller});
  final SellerProfileUi seller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return ListView(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      children: [
        if (seller.bio != null) ...[
          _AboutSection(
            title: 'Bio',
            child: Text(
              seller.bio!,
              style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
            ),
          ),
          const SizedBox(height: ZolyaSpacing.xl),
        ],
        _AboutSection(
          title: 'Information',
          child: Column(
            children: [
              _AboutRow(
                icon: LucideIcons.calendar,
                label: 'Member since',
                value: seller.memberSince.timeAgo,
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              _AboutRow(
                icon: LucideIcons.mapPin,
                label: 'Location',
                value: seller.city,
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              _AboutRow(
                icon: LucideIcons.shoppingBag,
                label: 'Articles published',
                value: '${seller.totalListings}',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              _AboutRow(
                icon: LucideIcons.checkCheck,
                label: 'Articles sold',
                value: '${seller.totalSales}',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              if (seller.languages.isNotEmpty)
                _AboutRow(
                  icon: LucideIcons.languages,
                  label: 'Languages',
                  value: seller.languages.join(', '),
                  mutedColor: mutedColor,
                  scheme: scheme,
                ),
            ],
          ),
        ),
        const SizedBox(height: ZolyaSpacing.xl),
        _AboutSection(
          title: 'Community',
          child: Row(
            children: [
              _CommunityChip(
                icon: LucideIcons.users,
                value: '${seller.followersCount}',
                label: 'followers',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              const SizedBox(width: ZolyaSpacing.md),
              _CommunityChip(
                icon: LucideIcons.userCheck,
                value: '${seller.followingCount}',
                label: 'following',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title.toUpperCase(),
          style: ZolyaTypography.label.copyWith(
            color: mutedColor,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: ZolyaSpacing.sm),
        child,
      ],
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.mutedColor,
    required this.scheme,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.sm + 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: mutedColor),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Text(
              label,
              style: ZolyaTypography.body.copyWith(color: mutedColor),
            ),
          ),
          Text(
            value,
            style: ZolyaTypography.body.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityChip extends StatelessWidget {
  const _CommunityChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.mutedColor,
    required this.scheme,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.md,
          vertical: ZolyaSpacing.md,
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: scheme.primary),
            const SizedBox(width: ZolyaSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: ZolyaTypography.subtitle.copyWith(
                      color: scheme.onSurface,
                    ),
                  ),
                  Text(
                    label,
                    style: ZolyaTypography.label.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
