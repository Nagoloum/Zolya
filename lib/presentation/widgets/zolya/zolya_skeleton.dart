import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ZolyaSkeleton extends StatelessWidget {
  const ZolyaSkeleton({
    super.key,
    required this.loading,
    required this.child,
    this.enableSwitchAnimation = true,
  });

  final bool loading;
  final Widget child;
  final bool enableSwitchAnimation;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: loading,
      enableSwitchAnimation: enableSwitchAnimation,
      child: child,
    );
  }
}

class ZolyaSkeletonBox extends StatelessWidget {
  const ZolyaSkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
