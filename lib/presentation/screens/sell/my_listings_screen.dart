import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../widgets/zolya/zolya.dart';

enum _ListingFilter { active, sold, draft }

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  _ListingFilter _filter = _ListingFilter.active;

  List<Product> _filteredProducts() {
    final user = FakeData.currentUser;
    final mine = FakeData.products
        .where((p) => p.sellerId == user.id)
        .toList(growable: false);
    final mock = mine.isEmpty ? FakeData.products.take(3).toList() : mine;
    return switch (_filter) {
      _ListingFilter.active =>
        mock.where((p) => p.status == ProductStatus.active).toList(),
      _ListingFilter.sold =>
        mock.where((p) => p.status == ProductStatus.sold).toList(),
      _ListingFilter.draft => const <Product>[],
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = _filteredProducts();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'My articles', centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RouteNames.createListing),
        icon: const Icon(LucideIcons.plus),
        label: const Text('Publish'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ZolyaSpacing.lg),
            child: ZolyaSegmentedControl<_ListingFilter>(
              value: _filter,
              segments: const [
                ZolyaSegment(value: _ListingFilter.active, label: 'Online'),
                ZolyaSegment(value: _ListingFilter.sold, label: 'Sold'),
                ZolyaSegment(value: _ListingFilter.draft, label: 'Drafts'),
              ],
              onChanged: (v) => setState(() => _filter = v),
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const ZolyaEmptyState(
                    icon: LucideIcons.shoppingBag,
                    title: 'Nothing here',
                    body:
                        "Vous n'avez aucun article dans cette catégorie. "
                        'Tap «Publish» to get started.',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      ZolyaSpacing.lg,
                      0,
                      ZolyaSpacing.lg,
                      120,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          onTap: () =>
                              context.push(RouteNames.productDetailPath(p.id)),
                          onToggleFavorite: () =>
                              context.read<FavoritesCubit>().toggle(p.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
