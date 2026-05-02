import 'package:flutter/material.dart';

import '../../../widgets/zolya/zolya.dart';

class RatingInline extends StatelessWidget {
  const RatingInline({
    super.key,
    required this.rating,
    required this.reviewsCount,
    required this.reviewsLabel,
    this.onTap,
  });

  final double rating;
  final int reviewsCount;
  final String reviewsLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ZolyaRatingInline(
      rating: rating,
      reviewsCount: reviewsCount,
      reviewsLabel: reviewsLabel,
      onTap: onTap,
    );
  }
}
