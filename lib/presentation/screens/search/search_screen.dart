import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_state.dart';
import '../../bloc/search/search_cubit.dart';
import '../../bloc/search/search_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/category_grid.dart';
import 'widgets/recent_searches_list.dart';
import 'widgets/search_no_results.dart';
import 'widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (_) => SearchCubit(),
      child: _SearchView(controller: _controller),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(
        title: l.searchTitle,
        centerTitle: true,
        actions: [
          ZolyaNotificationBell(
            onTap: () => context.push(RouteNames.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    ZolyaSpacing.lg,
                    ZolyaSpacing.sm,
                    ZolyaSpacing.lg,
                    ZolyaSpacing.lg,
                  ),
                  child: ZolyaSearchField(
                    controller: controller,
                    hint: l.discoverSearchHint,
                    autofocus: true,
                    onChanged: (v) => context.read<SearchCubit>().setQuery(v),
                  ),
                ),
                Expanded(
                  child: state.isBrowsing
                      ? _BrowsingView(
                          state: state,
                          recentTitle: l.searchRecent,
                          clearAllLabel: l.searchClearAll,
                          categoryItems: _categoryItems(l),
                          onApplyRecent: (v) {
                            controller.text = v;
                            controller.selection =
                                TextSelection.collapsed(offset: v.length);
                            context.read<SearchCubit>().setQuery(v);
                          },
                        )
                      : _ResultsView(
                          state: state,
                          noResultsTitle: l.searchNoResultsTitle,
                          noResultsBody: l.searchNoResultsBody,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<CategoryGridItem> _categoryItems(dynamic l) => [
        CategoryGridItem(
            id: 'tshirts', 
            label: l.categoryTshirts, 
            icon: LucideIcons.shirt),
        CategoryGridItem(
            id: 'jeans', 
            label: l.categoryJeans, 
            icon: LucideIcons.scan),
        CategoryGridItem(
            id: 'shoes', 
            label: l.categoryShoes, 
            icon: LucideIcons.footprints),
        CategoryGridItem(
            id: 'dresses',
            label: l.categoryDresses,
            icon: LucideIcons.userRound),
        CategoryGridItem(
            id: 'accessories',
            label: l.categoryAccessories,
            icon: LucideIcons.gem),
      ];
}

class _BrowsingView extends StatelessWidget {
  const _BrowsingView({
    required this.state,
    required this.recentTitle,
    required this.clearAllLabel,
    required this.categoryItems,
    required this.onApplyRecent,
  });

  final SearchState state;
  final String recentTitle;
  final String clearAllLabel;
  final List<CategoryGridItem> categoryItems;
  final ValueChanged<String> onApplyRecent;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.lg,
        vertical: ZolyaSpacing.xs,
      ),
      children: [
        CategoryGrid(
          items: categoryItems,
          selectedId: state.categoryId,
          onSelected: cubit.setCategory,
        ),
        const SizedBox(height: ZolyaSpacing.xxl),
        RecentSearchesList(
          recents: state.recents,
          title: recentTitle,
          clearAllLabel: clearAllLabel,
          onClearAll: cubit.clearRecents,
          onRemove: cubit.removeRecent,
          onTap: onApplyRecent,
        ),
        const SizedBox(height: ZolyaSpacing.xl),
      ],
    );
  }
}

class _ResultsView extends StatelessWidget {
  const _ResultsView({
    required this.state,
    required this.noResultsTitle,
    required this.noResultsBody,
  });

  final SearchState state;
  final String noResultsTitle;
  final String noResultsBody;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, productState) {
        final all = productState is ProductLoaded
            ? productState.products
            : FakeData.products;
        final results = context.read<SearchCubit>().filter(all);

        if (results.isEmpty) {
          return SearchNoResults(title: noResultsTitle, body: noResultsBody);
        }

        final theme = Theme.of(context);
        final isLight = theme.brightness == Brightness.light;
        final borderColor =
            isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg),
          itemCount: results.length,
          separatorBuilder: (_, __) => Divider(
            color: borderColor,
            height: 1,
            thickness: 0.5,
          ),
          itemBuilder: (_, i) => SearchResultTile(
            product: results[i],
            onTap: () => _onTap(context, results[i]),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, Product product) {
    if (state.query.isNotEmpty) {
      context.read<SearchCubit>().rememberSearch(state.query);
    }
    context.push(RouteNames.productDetailPath(product.id));
  }
}
