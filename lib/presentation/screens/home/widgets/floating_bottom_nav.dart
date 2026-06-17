import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/utils/platform_utils.dart';
import '../../../../theme/zolya_theme.dart';

class BottomNavTab {
  const BottomNavTab({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class FloatingBottomNav extends StatelessWidget {
  const FloatingBottomNav({
    super.key,
    required this.leftTabs,
    required this.rightTabs,
    required this.currentIndex,
    required this.onTap,
    required this.onSellTap,
    required this.sellIcon,
    this.sellTooltip = 'Sell',
  });

  final List<BottomNavTab> leftTabs;
  final List<BottomNavTab> rightTabs;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onSellTap;
  final IconData sellIcon;
  final String sellTooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final isIOS = PlatformUtils.isIOS(context);

    const radius = BorderRadius.all(Radius.circular(40));

    // --- Réglages du verre, adaptatifs par plateforme ---------------------
    // iOS = liquid glass (flou intense + sur-saturation) ; Android = givré.
    final double blurSigma = isIOS ? 30 : 18;
    // La barre reste assez opaque pour que les labels restent lisibles
    // par-dessus le contenu qui défile.
    final Color fillColor = isLight
        ? Colors.white.withValues(alpha: isIOS ? 0.62 : 0.75)
        : ZolyaColors.surfaceDark.withValues(alpha: isIOS ? 0.55 : 0.70);
    final Color borderColor = isLight
        ? Colors.white.withValues(alpha: isIOS ? 0.75 : 0.55)
        : Colors.white.withValues(alpha: 0.12);

    final ImageFilter blur = isIOS
        ? ImageFilter.compose(
            outer: ColorFilter.matrix(_saturationMatrix(1.5)),
            inner: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          )
        : ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma);

    final nav = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < leftTabs.length; i++)
          _NavItem(
            tab: leftTabs[i],
            selected: currentIndex == i,
            onTap: () => onTap(i),
          ),
        _SellCenterButton(
          icon: sellIcon,
          onTap: onSellTap,
          tooltip: sellTooltip,
        ),
        for (var i = 0; i < rightTabs.length; i++)
          _NavItem(
            tab: rightTabs[i],
            selected: currentIndex == leftTabs.length + i,
            onTap: () => onTap(leftTabs.length + i),
          ),
      ],
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          ZolyaSpacing.lg + 2,
          0,
          ZolyaSpacing.lg + 2,
          ZolyaSpacing.lg,
        ),
        // L'ombre doit rester à l'EXTÉRIEUR du ClipRRect, sinon elle est coupée.
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isLight ? 0.10 : 0.45),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: BackdropFilter(
              filter: blur,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: radius,
                  border: Border.all(color: borderColor, width: isIOS ? 1 : 0.8),
                ),
                child: Stack(
                  children: [
                    // Reflet spéculaire supérieur — signature liquid glass iOS.
                    if (isIOS)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 34,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.35),
                                  Colors.white.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    nav,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Matrice de saturation 5x4 pour [ColorFilter.matrix] (effet « vibrant »).
  static List<double> _saturationMatrix(double s) {
    const double lumR = 0.2126, lumG = 0.7152, lumB = 0.0722;
    final double sr = (1 - s) * lumR;
    final double sg = (1 - s) * lumG;
    final double sb = (1 - s) * lumB;
    return <double>[
      sr + s, sg, sb, 0, 0,
      sr, sg + s, sb, 0, 0,
      sr, sg, sb + s, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });
  final BottomNavTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final color = selected ? scheme.primary : mutedColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: ZolyaSpacing.sm + 2,
          vertical: ZolyaSpacing.xs + 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tab.icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: ZolyaTypography.label.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SellCenterButton extends StatelessWidget {
  const _SellCenterButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: ZolyaGradients.or,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: scheme.onPrimary, size: 26),
        ),
      ),
    );
  }
}
