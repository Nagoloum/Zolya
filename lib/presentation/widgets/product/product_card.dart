import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../domain/entities/product.dart';
import 'package:zolya/theme/zolya_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(
            imageUrl: product.mainImageUrl,
            isFavorite: isFavorite,
            onFavoriteTap: onFavoriteTap,
          ),
          const SizedBox(height: 10),
          Text(
            product.title,
            style: ZolyaTypography.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            Formatters.price(product.price),
            style: ZolyaTypography.caption.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const _ProductImage({
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ZolyaRadius.lg),
            child: Container(
              color: cs.outline,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: cs.outline),
                errorWidget: (_, __, ___) => Center(
                  child: Icon(Icons.image_outlined,
                      color: cs.onSurface.withValues(alpha: 0.45), size: 40),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _FavoriteButton(
              isFavorite: isFavorite,
              onTap: onFavoriteTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const _FavoriteButton({required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: ZolyaColors.blanc,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 18,
          color: isFavorite ? ZolyaColors.erreur : ZolyaColors.texte1,
        ),
      ),
    );
  }
}
