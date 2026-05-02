import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/fake/ui_models.dart';

class MomoLogo extends StatelessWidget {
  final MomoProvider provider;
  final double width;
  final double height;
  final BoxFit fit;

  const MomoLogo({
    super.key,
    required this.provider,
    this.width = 44,
    this.height = 28,
    this.fit = BoxFit.contain,
  });

  String get _asset => switch (provider) {
        MomoProvider.mtn => 'assets/icons/mtn.svg',
        MomoProvider.orange => 'assets/icons/orange_money.svg',
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(_asset, fit: fit),
    );
  }
}
