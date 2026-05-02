import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaProgress extends StatelessWidget {
  const ZolyaProgress({
    super.key,
    this.value,
    this.height = 6,
    this.color,
    this.backgroundColor,
  });

  final double? value;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value,
          color: color ?? ZolyaColors.or,
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.outline,
          minHeight: height,
        ),
      ),
    );
  }
}

class ZolyaStepProgress extends StatelessWidget {
  const ZolyaStepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    return Row(
      children: List.generate(totalSteps, (i) {
        final filled = i < currentStep;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < totalSteps - 1 ? 6 : 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4,
              decoration: BoxDecoration(
                color: filled ? ZolyaColors.or : outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }),
    );
  }
}
