import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_reviews_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../../bloc/reviews/reviews_cubit.dart';
import '../../bloc/reviews/reviews_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'detail_widgets/detail_bottom_bar.dart';
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
      create: (_) =>
          ReviewsCubit(repo: sl<ProductReviewsRepository>())..load(widget.productId),
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

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - 40;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(
        title: l.detailsTitle,
        centerTitle: true,
        actions: [
          ZolyaNotificationBell(
            onTap: () => context.push(RouteNames.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                Hero(
                  tag: 'product-image-${product.id}',
                  child: SizedBox(
                    width: contentWidth,
                    height: contentWidth,
                    child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
                      selector: (s) => s.isFavorite(product.id),
                      builder: (context, isFav) => ProductImageCarousel(
                        images: product.imageUrls,
                        isFavorite: isFav,
                        onFavoriteTap: () =>
                            context.read<FavoritesCubit>().toggle(product.id),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: ZolyaSpacing.xl),
                Text(product.title, style: ZolyaTypography.headline)
                    .animate()
                    .fadeIn(duration: 250.ms),
                const SizedBox(height: ZolyaSpacing.sm),
                _SummarySection(productId: product.id, label: l.detailsReviews),
                const SizedBox(height: ZolyaSpacing.lg),
                Text(
                  product.description,
                  style: ZolyaTypography.body.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.65)),
                ).animate().fadeIn(delay: 160.ms, duration: 300.ms),
                const SizedBox(height: ZolyaSpacing.xl),
              ],
            ),
          ),
          DetailBottomBar(
            price: product.price,
            priceLabel: l.detailsPrice,
            ctaLabel: l.detailsCheckout,
            onPressed: () =>
                context.push(RouteNames.checkoutPath(product.id)),
          ),
        ],
      ),
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
          return const SizedBox(height: 24, child: ZolyaSpinner(size: ZolyaSpinnerSize.sm));
        }
        return ZolyaRatingInline(
          rating: summary.average,
          reviewsCount: summary.totalRatings,
          reviewsLabel: label,
          onTap: () =>
              context.push(RouteNames.productReviewsPath(productId)),
        ).animate().fadeIn(duration: 250.ms);
      },
    );
  }
}
