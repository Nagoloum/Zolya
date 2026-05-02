import 'package:flutter/material.dart';

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
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          ZolyaSpacing.lg + 2,
          0,
          ZolyaSpacing.lg + 2,
          ZolyaSpacing.lg,
        ),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: borderColor, width: 0.8),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: isLight ? 0.08 : 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
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
          ),
        ),
      ),
    );
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
