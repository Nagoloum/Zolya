import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(title: 'Commande', centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          child: Center(
            child: Text(
              'Commande #$orderId',
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
