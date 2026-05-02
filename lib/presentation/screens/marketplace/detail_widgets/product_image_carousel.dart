import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  final List<String> images;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final _controller = PageController();
  final _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ZolyaRadius.lg),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.images.isEmpty)
            const _Placeholder()
          else
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (i) => _currentPage.value = i,
              itemBuilder: (_, i) {
                final theme = Theme.of(context);
                final placeholderColor = theme.brightness == Brightness.light
                    ? ZolyaColors.surface2
                    : ZolyaColors.surface2Dark;
                return CachedNetworkImage(
                  imageUrl: widget.images[i],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: placeholderColor),
                  errorWidget: (_, __, ___) => const _Placeholder(),
                );
              },
            ),
          Positioned(
            top: 12,
            right: 12,
            child: _FavoriteButton(
              isFavorite: widget.isFavorite,
              onTap: widget.onFavoriteTap,
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<int>(
                valueListenable: _currentPage,
                builder: (_, current, __) => _Dots(
                  count: widget.images.length,
                  current: current,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.current});
  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final selected = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: selected ? 22 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary
                : Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final iconColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    return Container(
      color: fillColor,
      alignment: Alignment.center,
      child: Icon(LucideIcons.imageOff, size: 48, color: iconColor),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onTap});
  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.sm + 1),
          child: Icon(
            LucideIcons.heart,
            size: 20,
            color: isFavorite ? scheme.error : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
