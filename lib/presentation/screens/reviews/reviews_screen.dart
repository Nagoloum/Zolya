import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../domain/repositories/product_reviews_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/reviews/reviews_cubit.dart';
import '../../bloc/reviews/reviews_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/rating_summary.dart';
import 'widgets/review_tile.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return BlocProvider<ReviewsCubit>(
      create: (_) =>
          ReviewsCubit(repo: sl<ProductReviewsRepository>())..load(productId),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ZolyaTopBar(title: l.reviewsTitle, centerTitle: true),
        body: SafeArea(
          child: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              if (state is ReviewsLoading || state is ReviewsInitial) {
                return const Center(child: ZolyaSpinner());
              }
              if (state is ReviewsError) {
                return ZolyaEmptyState(
                  icon: LucideIcons.circleX,
                  title: state.message,
                );
              }
              final loaded = state as ReviewsLoaded;
              final reviews = loaded.reviews;
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  RatingSummary(
                    average: loaded.summary.average,
                    totalRatings: loaded.summary.totalRatings,
                    breakdown: loaded.summary.breakdown,
                    ratingsLabel: l.reviewsRatingsLabel,
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                    height: 1,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: ZolyaSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${reviews.length} ${l.reviewsCountLabel}',
                          style: ZolyaTypography.title,
                        ),
                      ),
                      _SortMenu(label: l.reviewsSortMostRelevant),
                    ],
                  ),
                  for (var i = 0; i < reviews.length; i++) ...[
                    ReviewTile(data: reviews[i]),
                    if (i < reviews.length - 1)
                      Divider(
                        color: Theme.of(context).colorScheme.outline,
                        height: 1,
                        thickness: 0.5,
                      ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SortMenu extends StatelessWidget {
  const _SortMenu({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65);
    return Row(
      children: [
        Text(
          label,
          style: ZolyaTypography.caption.copyWith(color: muted),
        ),
        Icon(LucideIcons.chevronDown, size: 14, color: muted),
      ],
    );
  }
}
