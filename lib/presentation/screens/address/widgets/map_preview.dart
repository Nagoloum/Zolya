import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({super.key, this.height = 200, this.label, this.onTap});

  final double height;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mapBg = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final mutedColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _MapGridPainter(
                  gridColor: scheme.outline,
                  roadColor: mutedColor,
                ),
                child: Container(color: mapBg),
              ),
              Center(
                child: Icon(
                  LucideIcons.mapPin,
                  color: scheme.primary,
                  size: 36,
                ),
              ),
              if (label != null)
                Positioned(
                  left: ZolyaSpacing.md,
                  bottom: ZolyaSpacing.md,
                  right: ZolyaSpacing.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ZolyaSpacing.md,
                      vertical: ZolyaSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                      boxShadow: [
                        BoxShadow(
                          color: scheme.shadow.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      label!,
                      style: ZolyaTypography.bodySmall
                          .copyWith(color: scheme.onSurface),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  _MapGridPainter({required this.gridColor, required this.roadColor});

  final Color gridColor;
  final Color roadColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8;

    const step = 28.0;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final roadPaint = Paint()
      ..color = roadColor
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.4),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, 0),
      Offset(size.width * 0.6, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
