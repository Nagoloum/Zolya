import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../theme/zolya_theme.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(gradient: ZolyaGradients.orSubtil),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: ZolyaGradients.or,
              borderRadius: BorderRadius.circular(ZolyaRadius.xl),
              boxShadow: [
                BoxShadow(
                  color: ZolyaColors.or.withValues(alpha: 0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'Z',
              style: ZolyaTypography.displayLarge.copyWith(
                color: ZolyaColors.noir,
                fontSize: 72,
                height: 1,
              ),
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),
          const SizedBox(height: ZolyaSpacing.xl),
          Text(
            'ZOLYA',
            style: ZolyaTypography.displayMedium.copyWith(
              letterSpacing: 8,
              color: ZolyaColors.noir,
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
