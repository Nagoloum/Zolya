import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaGradientCard extends StatelessWidget {
  const ZolyaGradientCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(ZolyaSpacing.lg),
    this.gradient,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient ?? ZolyaGradients.or,
        borderRadius: BorderRadius.circular(ZolyaRadius.lg),
        boxShadow: [
          BoxShadow(
            color: ZolyaColors.or.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.lg),
        child: card,
      ),
    );
  }
}
