import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

enum ZolyaSpinnerSize { sm, md, lg }

class ZolyaSpinner extends StatelessWidget {
  const ZolyaSpinner({
    super.key,
    this.size = ZolyaSpinnerSize.md,
    this.color,
  });

  final ZolyaSpinnerSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dimension = switch (size) {
      ZolyaSpinnerSize.sm => 16.0,
      ZolyaSpinnerSize.md => 24.0,
      ZolyaSpinnerSize.lg => 36.0,
    };
    final stroke = switch (size) {
      ZolyaSpinnerSize.sm => 2.0,
      ZolyaSpinnerSize.md => 2.5,
      ZolyaSpinnerSize.lg => 3.0,
    };
    return SizedBox(
      width: dimension,
      height: dimension,
      child: CircularProgressIndicator(
        strokeWidth: stroke,
        color: color ?? ZolyaColors.or,
      ),
    );
  }
}
