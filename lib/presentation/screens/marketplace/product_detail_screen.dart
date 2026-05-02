import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_reviews_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../../domain/entities/product_comment.dart';
import '../../bloc/comments/comments_cubit.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../bloc/offers/offers_cubit.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../../bloc/reviews/reviews_cubit.dart';
import '../../bloc/reviews/reviews_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'detail_widgets/product_image_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductBloc>()
        .add(ProductDetailRequested(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return BlocProvider<ReviewsCubit>(
      create: (_) => ReviewsCubit(repo: sl<ProductReviewsRepository>())
        ..load(widget.productId),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductError) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: ZolyaTopBar(title: l.detailsTitle),
              body: Center(child: Text(state.message)),
            );
          }
          final Product product = state is ProductDetailLoaded
              ? state.product
              : FakeData.products.firstWhere(
                  (p) => p.id == widget.productId,
                  orElse: () => FakeData.products.first,
                );
          return _Content(product: product);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.product});
  final Product product;

  bool get _isOwner => product.sellerId == FakeData.currentUser.id;

  void _onShareTap(BuildContext context) {
    ZolyaShareSheet.show(
      context,
      title: product.title,
      shareUrl: 'https://zolya.app/product/${product.id}',
      subtitle: product.brand,
    );
  }

  void _onOfferTap(BuildContext context) {
    ZolyaPriceOfferSheet.show(
      context,
      productTitle: product.title,
      productPrice: product.price,
      onSubmit: (amount) async {
        final cubit = context.read<OffersCubit>();
        final offer = await cubit.sendOffer(
          productId: product.id,
          amount: amount,
        );
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              offer != null
                  ? 'Offer of ${Formatters.price(amount)} sent to ${product.sellerName}'
                  : "Couldn't send offer, please retry",
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - (ZolyaSpacing.lg * 2);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: ZolyaTopBar(
          title: l.detailsTitle,
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Share',
              icon: Icon(LucideIcons.share2, color: scheme.onSurface),
              onPressed: () => _onShareTap(context),
            ),
            ZolyaNotificationBell(
              onTap: () => context.push(RouteNames.notifications),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  ZolyaSpacing.lg,
                  ZolyaSpacing.xs,
                  ZolyaSpacing.lg,
                  ZolyaSpacing.xl,
                ),
                children: [
                  Hero(
                    tag: 'product-image-${product.id}',
                    child: SizedBox(
                      width: contentWidth,
                      height: contentWidth,
                      child: _isOwner
                          ? ProductImageCarousel(
                              images: product.imageUrls,
                              isFavorite: false,
                              onFavoriteTap: null,
                            )
                          : BlocSelector<FavoritesCubit, FavoritesState, bool>(
                              selector: (s) => s.isFavorite(product.id),
                              builder: (context, isFav) =>
                                  ProductImageCarousel(
                                images: product.imageUrls,
                                isFavorite: isFav,
                                onFavoriteTap: () => context
                                    .read<FavoritesCubit>()
                                    .toggle(product.id),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  _HeaderSection(product: product, mutedColor: mutedColor)
                      .animate()
                      .fadeIn(duration: 250.ms),
                  const SizedBox(height: ZolyaSpacing.lg),
                  _MetaRow(product: product, mutedColor: mutedColor),
                  const SizedBox(height: ZolyaSpacing.lg),
                  Divider(color: borderColor, height: 1),
                  const SizedBox(height: ZolyaSpacing.lg),
                  _SummarySection(
                    productId: product.id,
                    label: l.detailsReviews,
                  ),
                  const SizedBox(height: ZolyaSpacing.lg),
                  Text(
                    'Description',
                    style: ZolyaTypography.subtitle
                        .copyWith(color: scheme.onSurface),
                  ),
                  const SizedBox(height: ZolyaSpacing.sm),
                  Text(
                    product.description,
                    style: ZolyaTypography.body.copyWith(color: mutedColor),
                  ).animate().fadeIn(delay: 160.ms, duration: 300.ms),
                  if (!_isOwner) ...[
                    const SizedBox(height: ZolyaSpacing.xl),
                    _SellerCard(product: product),
                  ],
                  const SizedBox(height: ZolyaSpacing.xl),
                  _CommentsSection(productId: product.id, isOwner: _isOwner),
                  const SizedBox(height: ZolyaSpacing.xl),
                  _ProductTabs(product: product),
                ],
              ),
            ),
            _isOwner
                ? _OwnerBottomBar(
                    onEditTap: () => context.push(RouteNames.createListing),
                  )
                : _BottomBar(
                    product: product,
                    priceLabel: l.detailsPrice,
                    ctaLabel: l.detailsCheckout,
                    onOfferTap: () => _onOfferTap(context),
                    onCheckoutTap: () =>
                        context.push(RouteNames.checkoutPath(product.id)),
                  ),
          ],
        ),
      ),
    );
  }
}

class _OwnerBottomBar extends StatelessWidget {
  const _OwnerBottomBar({required this.onEditTap});
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outline)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.lg,
          vertical: ZolyaSpacing.md,
        ),
        child: ZolyaButton(
          label: l.ownerEditCta,
          leading: const Icon(LucideIcons.pencil, size: 18),
          onPressed: onEditTap,
          size: ZolyaButtonSize.lg,
          expand: true,
        ),
      ),
    );
  }
}

class _CommentsSection extends StatefulWidget {
  const _CommentsSection({required this.productId, required this.isOwner});
  final String productId;
  final bool isOwner;

  @override
  State<_CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<_CommentsSection> {
  @override
  void initState() {
    super.initState();
    context.read<CommentsCubit>().seedFor(widget.productId);
  }

  void _onAddTap() {
    ZolyaCommentSheet.show(
      context,
      onSubmit: (text, rating) {
        context.read<CommentsCubit>().post(
              productId: widget.productId,
              text: text,
              rating: rating,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.commentsPosted)),
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

    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        final comments = state.commentsFor(widget.productId);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${l.commentsTitle} (${comments.length})',
                    style: ZolyaTypography.subtitle
                        .copyWith(color: scheme.onSurface),
                  ),
                ),
                if (!widget.isOwner)
                  TextButton.icon(
                    onPressed: _onAddTap,
                    icon: Icon(LucideIcons.plus,
                        size: 16, color: scheme.primary),
                    label: Text(
                      l.commentsAddCta,
                      style: ZolyaTypography.bodySmall.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            if (comments.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: ZolyaSpacing.lg),
                child: Text(
                  l.commentsEmpty,
                  style:
                      ZolyaTypography.body.copyWith(color: mutedColor),
                ),
              )
            else
              ...comments.take(3).map(
                    (c) => _CommentRow(
                      comment: c,
                      mutedColor: mutedColor,
                      scheme: scheme,
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    required this.comment,
    required this.mutedColor,
    required this.scheme,
  });
  final ProductComment comment;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZolyaAvatar(
            name: comment.authorName,
            imageUrl: comment.authorAvatarUrl,
            size: ZolyaAvatarSize.sm,
            useGradient: false,
          ),
          const SizedBox(width: ZolyaSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.authorName,
                      style: ZolyaTypography.bodySmall.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: ZolyaSpacing.sm),
                    Text(
                      comment.createdAt.timeAgo,
                      style:
                          ZolyaTypography.label.copyWith(color: mutedColor),
                    ),
                  ],
                ),
                if (comment.rating > 0) ...[
                  const SizedBox(height: 2),
                  ZolyaStarsRow(rating: comment.rating, size: 12),
                ],
                const SizedBox(height: 2),
                Text(
                  comment.text,
                  style:
                      ZolyaTypography.body.copyWith(color: scheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.product, required this.mutedColor});
  final Product product;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.brand != null && product.brand!.isNotEmpty) ...[
          Text(
            product.brand!.toUpperCase(),
            style: ZolyaTypography.label.copyWith(
              color: scheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: ZolyaSpacing.xs),
        ],
        Text(
          product.title,
          style: ZolyaTypography.headline.copyWith(color: scheme.onSurface),
        ),
        const SizedBox(height: ZolyaSpacing.sm),
        Text(
          Formatters.price(product.price),
          style: ZolyaTypography.displayMedium.copyWith(
            color: scheme.primary,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.product, required this.mutedColor});
  final Product product;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesCubit, FavoritesState, bool>(
      selector: (s) => s.isFavorite(product.id),
      builder: (context, isFav) {
        final likes = product.likesCount + (isFav ? 1 : 0);
        return Row(
          children: [
            _MetaChip(
              icon: LucideIcons.clock3,
              label: product.createdAt.timeAgo,
              mutedColor: mutedColor,
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            _MetaChip(
              icon: LucideIcons.heart,
              label: '$likes',
              mutedColor: mutedColor,
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            _MetaChip(
              icon: LucideIcons.eye,
              label: '${product.viewsCount}',
              mutedColor: mutedColor,
            ),
            if (product.size != null) ...[
              const SizedBox(width: ZolyaSpacing.sm),
              _MetaChip(
                icon: LucideIcons.ruler,
                label: product.size!,
                mutedColor: mutedColor,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.mutedColor,
  });
  final IconData icon;
  final String label;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: mutedColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: ZolyaTypography.bodySmall.copyWith(
            color: mutedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.productId, required this.label});
  final String productId;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      buildWhen: (prev, curr) => curr is ReviewsLoaded || curr is ReviewsError,
      builder: (context, state) {
        ProductRatingSummary? summary;
        if (state is ReviewsLoaded) summary = state.summary;
        if (summary == null) {
          return const SizedBox(
            height: 24,
            child: ZolyaSpinner(size: ZolyaSpinnerSize.sm),
          );
        }
        return ZolyaRatingInline(
          rating: summary.average,
          reviewsCount: summary.totalRatings,
          reviewsLabel: label,
          onTap: () => context.push(RouteNames.productReviewsPath(productId)),
        ).animate().fadeIn(duration: 250.ms);
      },
    );
  }
}

class _SellerCard extends StatelessWidget {
  const _SellerCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final seller = FakeData.sellerFor(product.sellerId);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(RouteNames.sellerProfilePath(product.sellerId)),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Container(
          padding: const EdgeInsets.all(ZolyaSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ZolyaAvatar(
                    name: seller.fullName,
                    imageUrl: seller.avatarUrl,
                    size: ZolyaAvatarSize.md,
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
                                seller.fullName,
                                style: ZolyaTypography.subtitle
                                    .copyWith(color: scheme.onSurface),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (seller.isVerified) ...[
                              const SizedBox(width: ZolyaSpacing.xs),
                              Icon(LucideIcons.badgeCheck,
                                  size: 16, color: scheme.primary),
                            ],
                          ],
                        ),
                        const SizedBox(height: ZolyaSpacing.xs / 2),
                        Row(
                          children: [
                            Icon(LucideIcons.star,
                                size: 12, color: scheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              '${seller.averageRating.toStringAsFixed(1)} '
                              '(${seller.totalReviews})',
                              style: ZolyaTypography.bodySmall
                                  .copyWith(color: mutedColor),
                            ),
                            const SizedBox(width: ZolyaSpacing.sm),
                            Text(
                              '${seller.totalSales} ventes',
                              style: ZolyaTypography.bodySmall
                                  .copyWith(color: mutedColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(LucideIcons.chevronRight,
                      size: 18, color: mutedColor),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.md),
              const Divider(height: 1, thickness: 0.5),
              const SizedBox(height: ZolyaSpacing.md),
              _SellerReviewsPreview(sellerId: product.sellerId),
            ],
          ),
        ),
      ),
    );
  }
}

class _SellerReviewsPreview extends StatelessWidget {
  const _SellerReviewsPreview({required this.sellerId});
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final reviews = FakeData.sellerReviews(sellerId).take(2).toList();

    if (reviews.isEmpty) {
      return Text(
        'No reviews yet',
        style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.messageSquareQuote,
                size: 14, color: scheme.primary),
            const SizedBox(width: ZolyaSpacing.xs),
            Text(
              'Reviews about the seller',
              style: ZolyaTypography.label.copyWith(
                color: scheme.primary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: ZolyaSpacing.sm),
        for (final r in reviews) ...[
          _ReviewRow(review: r, mutedColor: mutedColor),
          if (r != reviews.last) const SizedBox(height: ZolyaSpacing.sm),
        ],
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.review, required this.mutedColor});
  final ReviewItemData review;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              review.author,
              style: ZolyaTypography.bodySmall.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            ZolyaStarsRow(rating: review.rating, size: 12),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          review.comment,
          style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ProductTabs extends StatelessWidget {
  const _ProductTabs({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor),
            ),
          ),
          child: TabBar(
            isScrollable: false,
            indicatorColor: scheme.primary,
            indicatorWeight: 2,
            labelColor: scheme.primary,
            unselectedLabelColor: mutedColor,
            labelStyle: ZolyaTypography.subtitle,
            unselectedLabelStyle: ZolyaTypography.subtitle,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'From seller'),
              Tab(text: 'Similar'),
            ],
          ),
        ),
        const SizedBox(height: ZolyaSpacing.md),
        SizedBox(
          height: 280,
          child: TabBarView(
            children: [
              _ProductHorizontalList(
                products: FakeData.productsBySeller(product.sellerId)
                    .where((p) => p.id != product.id)
                    .toList(),
                emptyMessage: 'No other items from this seller',
              ),
              _ProductHorizontalList(
                products: FakeData.similarProducts(product),
                emptyMessage: 'No similar item found',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductHorizontalList extends StatelessWidget {
  const _ProductHorizontalList({
    required this.products,
    required this.emptyMessage,
  });
  final List<Product> products;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    if (products.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ),
      );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(width: ZolyaSpacing.md),
      itemBuilder: (_, i) {
        final p = products[i];
        return SizedBox(
          width: 160,
          child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
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
          ),
        );
      },
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.product,
    required this.priceLabel,
    required this.ctaLabel,
    required this.onOfferTap,
    required this.onCheckoutTap,
  });

  final Product product;
  final String priceLabel;
  final String ctaLabel;
  final VoidCallback onOfferTap;
  final VoidCallback onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outline)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.lg,
          vertical: ZolyaSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: ZolyaButton(
                variant: ZolyaButtonVariant.outline,
                label: 'Make an offer',
                leading: const Icon(LucideIcons.tag, size: 18),
                onPressed: onOfferTap,
                size: ZolyaButtonSize.lg,
                expand: true,
              ),
            ),
            const SizedBox(width: ZolyaSpacing.sm + 2),
            Expanded(
              child: ZolyaButton(
                label: ctaLabel,
                leading: const Icon(LucideIcons.shoppingBag, size: 18),
                onPressed: onCheckoutTap,
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
