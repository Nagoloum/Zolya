import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaPhotoGrid extends StatelessWidget {
  const ZolyaPhotoGrid({
    super.key,
    required this.images,
    required this.maxCount,
    required this.onPick,
    required this.onRemove,
    this.tileSize = 100,
  });

  final List<XFile> images;
  final int maxCount;
  final VoidCallback onPick;
  final ValueChanged<int> onRemove;
  final double tileSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < images.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _PhotoTile(
                file: images[i],
                size: tileSize,
                onRemove: () => onRemove(i),
              ),
            ),
          if (images.length < maxCount)
            _AddTile(size: tileSize, onTap: onPick),
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.file,
    required this.size,
    required this.onRemove,
  });
  final XFile file;
  final double size;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
          child: Image.file(
            File(file.path),
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: ZolyaSpacing.xs,
          right: ZolyaSpacing.xs,
          child: Material(
            color: scheme.error,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(ZolyaSpacing.xs),
                child: Icon(LucideIcons.x, size: 12, color: scheme.onError),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.size, required this.onTap});
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final iconColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZolyaRadius.md),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(ZolyaRadius.md),
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child: Icon(LucideIcons.plus, color: iconColor, size: 28),
      ),
    );
  }
}
