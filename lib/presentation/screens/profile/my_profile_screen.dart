import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/user.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../widgets/zolya/zolya.dart';
import '../reviews/widgets/rating_summary.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return _Content(user: user);
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.user});
  final User? user;

  void _onShareProfile(BuildContext context) {
    if (user == null) return;
    ZolyaShareSheet.show(
      context,
      title: user!.fullName,
      shareUrl: 'https://zolya.app/u/${user!.id}',
      subtitle: 'Découvrez mon profil sur Zolya',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = user != null
        ? FakeData.productsBySeller(user!.id)
        : <Product>[];
    final mockProducts = products.isEmpty
        ? FakeData.products.take(4).toList()
        : products;

    final l = context.l10n;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: ZolyaTopBar(
          title: user?.fullName ?? '—',
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: l.commonEdit,
              icon: Icon(LucideIcons.pencil,
                  color: theme.colorScheme.onSurface),
              onPressed: () => context.push(RouteNames.editProfile),
            ),
            IconButton(
              tooltip: l.commonShare,
              icon: Icon(LucideIcons.share2, color: theme.colorScheme.onSurface),
              onPressed: () => _onShareProfile(context),
            ),
          ],
        ),
        body: Column(
          children: [
            _MyHeader(user: user).animate().fadeIn(duration: 250.ms),
            const _MyTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _ListingsTab(products: mockProducts),
                  _ReviewsTab(userId: user?.id ?? ''),
                  _AboutTab(user: user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyHeader extends StatelessWidget {
  const _MyHeader({required this.user});
  final User? user;

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
                name: user?.fullName ?? '—',
                imageUrl: user?.avatarUrl,
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
                            user?.fullName ?? '—',
                            style: ZolyaTypography.headline
                                .copyWith(color: scheme.onSurface),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (user?.isVerified ?? false) ...[
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
                          (user?.ratingAvg ?? 4.8).toStringAsFixed(1),
                          style: ZolyaTypography.bodySmall
                              .copyWith(color: mutedColor),
                        ),
                        const SizedBox(width: ZolyaSpacing.xs),
                        Text(
                          '(${user?.ratingCount ?? 52})',
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
                          'Douala',
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
          Builder(builder: (context) {
            final l = context.l10n;
            return Row(
              children: [
                Expanded(
                  child: _Stat(
                    value: '12',
                    label: l.profileStatArticles,
                    mutedColor: mutedColor,
                  ),
                ),
                _StatDivider(),
                Expanded(
                  child: _Stat(
                    value: '34',
                    label: l.profileStatSales,
                    mutedColor: mutedColor,
                  ),
                ),
                _StatDivider(),
                Expanded(
                  child: _Stat(
                    value: '128',
                    label: l.profileStatFollowers,
                    mutedColor: mutedColor,
                  ),
                ),
              ],
            );
          }),
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

class _MyTabBar extends StatelessWidget {
  const _MyTabBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    final l = context.l10n;

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
        tabs: [
          Tab(text: l.profileTabListings),
          Tab(text: l.profileTabReviews),
          Tab(text: l.profileTabAbout),
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
    final l = context.l10n;
    if (products.isEmpty) {
      return ZolyaEmptyState(
        icon: LucideIcons.shoppingBag,
        title: l.profileNoListingsTitle,
        body: l.profileNoListingsBody,
        actionLabel: l.profileNoListingsCta,
        onAction: () => context.push(RouteNames.createListing),
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
  const _ReviewsTab({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    final seed = userId.isEmpty ? 'u-001' : userId;
    final reviews = FakeData.sellerReviews(seed);
    const average = 4.8;
    const total = 52;
    const breakdown = [38, 9, 3, 1, 1];

    return ListView(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      children: [
        const RatingSummary(
          average: average,
          totalRatings: total,
          breakdown: breakdown,
          ratingsLabel: 'avis',
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
  const _AboutTab({required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(ZolyaSpacing.lg),
      children: [
        _AboutSection(
          title: l.aboutBioTitle,
          mutedColor: mutedColor,
          child: Text(
            l.aboutBioDefault,
            style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
          ),
        ),
        const SizedBox(height: ZolyaSpacing.xl),
        _AboutSection(
          title: l.aboutPersonalInfo,
          mutedColor: mutedColor,
          child: Column(
            children: [
              _AboutRow(
                icon: LucideIcons.userRound,
                label: l.aboutUsername,
                value: user?.fullName ?? '—',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              _AboutRow(
                icon: LucideIcons.phone,
                label: l.aboutPhone,
                value: user?.phone ?? '—',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              if (user?.email != null && user!.email!.isNotEmpty)
                _AboutRow(
                  icon: LucideIcons.mail,
                  label: l.aboutEmail,
                  value: user!.email!,
                  mutedColor: mutedColor,
                  scheme: scheme,
                ),
              _AboutRow(
                icon: LucideIcons.mapPin,
                label: l.aboutLocation,
                value: 'Douala, Cameroon',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              _AboutRow(
                icon: LucideIcons.calendar,
                label: l.aboutMemberSince,
                value: user?.createdAt.timeAgo ?? '—',
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              if (user?.isVerified ?? false)
                _AboutRow(
                  icon: LucideIcons.badgeCheck,
                  label: l.aboutVerified,
                  value: l.commonYes,
                  mutedColor: mutedColor,
                  scheme: scheme,
                ),
            ],
          ),
        ),
        const SizedBox(height: ZolyaSpacing.lg),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({
    required this.title,
    required this.child,
    required this.mutedColor,
  });
  final String title;
  final Widget child;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
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

