import 'package:flutter/material.dart';

import '../../../../data/fake/ui_models.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';

export '../../../../data/fake/ui_models.dart' show ReviewItemData;

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.data});
  final ReviewItemData data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZolyaStarsRow(rating: data.rating, size: 14),
          const SizedBox(height: 10),
          Text(data.comment, style: ZolyaTypography.body),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              style: ZolyaTypography.caption
                  .copyWith(color: cs.onSurface.withValues(alpha: 0.65)),
              children: [
                TextSpan(
                  text: data.author,
                  style: ZolyaTypography.caption.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: '  •  '),
                TextSpan(text: data.timeAgo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
