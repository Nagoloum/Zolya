import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/product.dart';
import '../../../../theme/zolya_theme.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key, required this.product, this.onTap});
  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.md),
        child: Row(
          children: [
            _Thumb(imageUrl: product.mainImageUrl),
            const SizedBox(width: ZolyaSpacing.md + 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: ZolyaTypography.subtitle
                        .copyWith(color: scheme.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: ZolyaSpacing.xs),
                  Text(
                    Formatters.price(product.price),
                    style: ZolyaTypography.bodySmall.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: ZolyaSpacing.sm),
            Icon(LucideIcons.arrowUpRight, size: 18, color: mutedColor),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final iconColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: Container(
        width: 56,
        height: 56,
        color: placeholderColor,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: placeholderColor),
          errorWidget: (_, __, ___) =>
              Icon(LucideIcons.imageOff, color: iconColor),
        ),
      ),
    );
  }
}
