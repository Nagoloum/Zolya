import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../theme/zolya_theme.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock({
    super.key,
    required this.label,
    required this.fullAddress,
  });

  final String label;
  final String fullAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: ZolyaColors.or50,
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          ),
          alignment: Alignment.center,
          child: const Icon(LucideIcons.mapPin,
              size: 18, color: ZolyaColors.or700),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: ZolyaTypography.subtitle),
              const SizedBox(height: 4),
              Text(
                fullAddress,
                style: ZolyaTypography.body.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
