import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaProductCard extends StatelessWidget {
  const ZolyaProductCard({
    super.key,
    required this.title,
    required this.priceLabel,
    this.imageUrl,
    this.subtitle,
    this.favorite = false,
    this.onTap,
    this.onToggleFavorite,
    this.loading = false,
    this.aspectRatio = 0.85,
  });

  final String title;
  final String priceLabel;
  final String? imageUrl;
  final String? subtitle;
  final bool favorite;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;
  final bool loading;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final placeholderIconColor =
        isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return Skeletonizer(
      enabled: loading,
      child: InkWell(
        onTap: loading ? null : onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ZolyaRadius.md),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (imageUrl != null && imageUrl!.isNotEmpty && !loading)
                      CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: placeholderColor),
                        errorWidget: (_, __, ___) => Container(
                          color: placeholderColor,
                          child: Icon(LucideIcons.imageOff,
                              color: placeholderIconColor),
                        ),
                      )
                    else
                      Container(color: placeholderColor),
                    if (onToggleFavorite != null)
                      Positioned(
                        top: ZolyaSpacing.sm,
                        right: ZolyaSpacing.sm,
                        child: _FavoriteButton(
                          active: favorite,
                          onTap: onToggleFavorite,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            Text(
              title,
              style: ZolyaTypography.subtitle.copyWith(color: scheme.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: ZolyaSpacing.xs / 2),
              Text(
                subtitle!,
                style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: ZolyaSpacing.xs),
            Text(
              priceLabel,
              style: ZolyaTypography.title.copyWith(color: scheme.primary),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.05, end: 0, duration: 250.ms);
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.active, this.onTap});
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface.withValues(alpha: 0.85),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.xs + 2),
          child: Icon(
            LucideIcons.heart,
            size: 18,
            color: active ? scheme.error : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
