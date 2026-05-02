import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaGradientCard extends StatelessWidget {
  const ZolyaGradientCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(ZolyaSpacing.lg),
    this.gradient,
  });

  final Widget child;
  final EdgeInsets padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
