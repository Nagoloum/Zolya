import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/favorites/favorites_cubit.dart';
import '../../bloc/favorites/favorites_state.dart';
import '../../widgets/zolya/zolya.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'My favorites', centerTitle: true),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final liked = FakeData.products
              .where((p) => state.ids.contains(p.id))
              .toList();

          if (liked.isEmpty) {
            return ZolyaEmptyState(
              icon: LucideIcons.heart,
              title: 'No favorites yet',
              body:
                  'Like the items you love by tapping the heart — '
                  'you will find them all here.',
              actionLabel: 'Discover',
              onAction: () => context.go(RouteNames.marketplace),
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
            itemCount: liked.length,
            itemBuilder: (_, i) {
              final p = liked[i];
              return ZolyaProductCard(
                title: p.title,
                priceLabel: Formatters.price(p.price),
                imageUrl: p.mainImageUrl,
                subtitle: p.brand,
                favorite: true,
                onTap: () => context.push(RouteNames.productDetailPath(p.id)),
                onToggleFavorite: () =>
                    context.read<FavoritesCubit>().toggle(p.id),
              );
            },
          );
        },
      ),
    );
  }
}
