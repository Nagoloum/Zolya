import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/product.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../../widgets/common/filter_bottom_sheet.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/category_chips.dart';
import 'widgets/discover_header.dart';
import 'widgets/discover_search_bar.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final _scrollController = ScrollController();

  String _selectedCategoryId = 'all';
  ProductFilters _filters = const ProductFilters();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductLoadRequested());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductBloc>().add(ProductLoadMoreRequested());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String id) {
    setState(() => _selectedCategoryId = id);
    context.read<ProductBloc>().add(
          ProductFilterChanged(category: id == 'all' ? null : id),
        );
  }

  Future<void> _openFilters() async {
    final result = await FilterBottomSheet.show(context, initial: _filters);
    if (result != null) {
      setState(() => _filters = result);
    }
  }

  List<Product> _applyFilters(List<Product> products) {
    final list = products.where((p) {
      if (p.price < _filters.priceRange.start) return false;
      if (p.price > _filters.priceRange.end) return false;
      if (_filters.size != null && p.size != null && p.size != _filters.size) {
        return false;
      }
      return true;
    }).toList();

    switch (_filters.sort) {
      case SortOption.priceLowHigh:
        list.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceHighLow:
        list.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.relevance:
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final categories = [
      CategoryOption(id: 'all', label: l.categoryAll),
      CategoryOption(id: 'tshirts', label: l.categoryTshirts),
      CategoryOption(id: 'jeans', label: l.categoryJeans),
      CategoryOption(id: 'shoes', label: l.categoryShoes),
      CategoryOption(id: 'dresses', label: l.categoryDresses),
      CategoryOption(id: 'accessories', label: l.categoryAccessories),
    ];

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              ZolyaSpacing.lg,
              ZolyaSpacing.sm,
              ZolyaSpacing.lg,
              ZolyaSpacing.lg,
            ),
            child: Column(
              children: [
                DiscoverHeader(
                  title: l.homeTitle,
                  hasUnreadNotifications: true,
                  onNotificationsTap: () =>
                      context.push(RouteNames.notifications),
                ).animate().fadeIn(duration: 250.ms),
                const SizedBox(height: ZolyaSpacing.lg),
                DiscoverSearchBar(
                  hint: l.discoverSearchHint,
                  onTap: () => context.go(RouteNames.search),
                  onFilterTap: _openFilters,
                )
                    .animate()
                    .fadeIn(delay: 80.ms, duration: 250.ms)
                    .slideY(begin: 0.1, end: 0, delay: 80.ms, duration: 250.ms),
              ],
            ),
          ),
          CategoryChips(
            categories: categories,
            selectedId: _selectedCategoryId,
            onSelected: _onCategorySelected,
          ).animate().fadeIn(delay: 160.ms, duration: 250.ms),
          const SizedBox(height: ZolyaSpacing.lg),
          Expanded(
            child: _ProductGrid(
              scrollController: _scrollController,
              filterFn: _applyFilters,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.scrollController,
    required this.filterFn,
  });

  final ScrollController scrollController;
  final List<Product> Function(List<Product>) filterFn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return _Grid(
            controller: scrollController,
            itemCount: 6,
            itemBuilder: (_, __) => const ZolyaProductCard(
              title: '████████',
              priceLabel: '████',
              loading: true,
            ),
          );
        }

        if (state is ProductError) {
          return _ErrorView(
            message: state.message,
            onRetry: () =>
                context.read<ProductBloc>().add(ProductLoadRequested()),
          );
        }

        if (state is ProductLoaded) {
          final products = filterFn(state.products);
          if (products.isEmpty) {
            return const _EmptyView();
          }
          return _Grid(
            controller: scrollController,
            itemCount: products.length + (state is ProductLoadingMore ? 2 : 0),
            itemBuilder: (_, index) {
              if (index >= products.length) {
                return const ZolyaProductCard(
                  title: '████████',
                  priceLabel: '████',
                  loading: true,
                );
              }
              final product = products[index];
              return BlocSelector<FavoritesCubit, FavoritesState, bool>(
                selector: (s) => s.isFavorite(product.id),
                builder: (context, isFav) => ZolyaProductCard(
                  title: product.title,
                  priceLabel: Formatters.price(product.price),
                  imageUrl: product.mainImageUrl,
                  subtitle: product.brand,
                  favorite: isFav,
                  onTap: () =>
                      context.push(RouteNames.productDetailPath(product.id)),
                  onToggleFavorite: () =>
                      context.read<FavoritesCubit>().toggle(product.id),
                ),
              );
            },
          );
        }

        return const Center(child: ZolyaSpinner());
      },
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
  });

  final ScrollController controller;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(
        ZolyaSpacing.lg,
        0,
        ZolyaSpacing.lg,
        120,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ZolyaSpacing.lg,
        crossAxisSpacing: ZolyaSpacing.md + 2,
        childAspectRatio: 0.62,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final iconColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final bodyColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.shoppingBag, size: 48, color: iconColor),
          const SizedBox(height: ZolyaSpacing.md),
          Text(
            'Aucun article ne correspond aux filtres',
            style: ZolyaTypography.body.copyWith(color: bodyColor),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ZolyaSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.circleX, size: 48, color: scheme.error),
            const SizedBox(height: ZolyaSpacing.md),
            Text(
              message,
              style: ZolyaTypography.body.copyWith(color: scheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            ZolyaButton(
              variant: ZolyaButtonVariant.outline,
              label: 'Réessayer',
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
