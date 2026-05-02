import 'package:flutter/material.dart';
import '../../../domain/entities/order.dart';
import 'package:zolya/theme/zolya_theme.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = _config(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(label, style: ZolyaTypography.label.copyWith(color: color)),
    );
  }

  (Color, String) _config(BuildContext context, OrderStatus status) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
    return switch (status) {
      OrderStatus.pendingPayment => (ZolyaColors.avertissement, 'En attente de paiement'),
      OrderStatus.paid => (ZolyaColors.or700, 'Paiement securise'),
      OrderStatus.awaitingCourier => (ZolyaColors.avertissement, 'Recherche livreur'),
      OrderStatus.assignedToDeliverer => (ZolyaColors.info, 'Pris en charge'),
      OrderStatus.pickedUp => (ZolyaColors.info, 'Colis recupere'),
      OrderStatus.inDelivery => (ZolyaColors.info, 'En livraison'),
      OrderStatus.delivered => (ZolyaColors.succes, 'Livre'),
      OrderStatus.disputed => (ZolyaColors.avertissement, 'Litige'),
      OrderStatus.cancelled => (muted, 'Annule'),
      OrderStatus.refunded => (muted, 'Rembourse'),
    };
  }
}
