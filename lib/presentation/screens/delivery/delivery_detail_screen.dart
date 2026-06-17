import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/delivery.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

/// Détail d'une course pour le livreur : adresses, contacts, et action
/// principale qui fait progresser le statut (accepter → récupéré → livré).
class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({super.key, required this.deliveryId});
  final String deliveryId;

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  Delivery? get _delivery => FakeData.deliveryById(widget.deliveryId);

  ZolyaBadgeVariant _variant(DeliveryStatus status) {
    return switch (status) {
      DeliveryStatus.completed => ZolyaBadgeVariant.success,
      DeliveryStatus.failed => ZolyaBadgeVariant.error,
      DeliveryStatus.available => ZolyaBadgeVariant.warning,
      _ => ZolyaBadgeVariant.primary,
    };
  }

  String? _actionLabel(DeliveryStatus status) {
    return switch (status) {
      DeliveryStatus.available => 'Accept delivery',
      DeliveryStatus.assigned => 'Mark as picked up',
      DeliveryStatus.pickedUp => 'Start delivery',
      DeliveryStatus.inProgress => 'Mark as delivered',
      DeliveryStatus.completed || DeliveryStatus.failed => null,
    };
  }

  void _onAction(Delivery d) {
    if (d.status == DeliveryStatus.available) {
      FakeData.acceptDelivery(d.id);
    } else {
      FakeData.advanceDelivery(d.id);
    }
    setState(() {});
    final updated = _delivery;
    if (updated?.status == DeliveryStatus.completed && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delivery completed. Well done!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final d = _delivery;

    if (d == null) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const ZolyaTopBar(title: 'Delivery', centerTitle: true),
        body: const ZolyaEmptyState(
          icon: LucideIcons.packageX,
          title: 'Delivery not found',
          body: 'This delivery is no longer available.',
        ),
      );
    }

    final actionLabel = _actionLabel(d.status);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: 'Delivery #${d.orderId}', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZolyaBadge(label: d.statusLabel, variant: _variant(d.status)),
                Text(
                  '${Formatters.price(d.fee)} fee',
                  style: ZolyaTypography.subtitle.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _RouteCard(
              pickup: d.pickupAddress,
              dropoff: d.dropoffAddress,
              dropoffNeighborhood: d.dropoffNeighborhood,
              scheme: scheme,
              mutedColor: mutedColor,
              isLight: isLight,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _SectionTitle(title: 'CONTACTS', mutedColor: mutedColor),
            const SizedBox(height: ZolyaSpacing.sm),
            _ContactTile(
              icon: LucideIcons.store,
              role: 'Seller (pickup)',
              name: d.sellerName,
              phone: d.sellerPhone,
              scheme: scheme,
              mutedColor: mutedColor,
              isLight: isLight,
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            _ContactTile(
              icon: LucideIcons.user,
              role: 'Buyer (dropoff)',
              name: d.buyerName,
              phone: d.buyerPhone,
              scheme: scheme,
              mutedColor: mutedColor,
              isLight: isLight,
            ),
            const SizedBox(height: ZolyaSpacing.xxl),
            if (actionLabel != null)
              ZolyaButton(
                label: actionLabel,
                leading: const Icon(LucideIcons.truck, size: 18),
                onPressed: () => _onAction(d),
                expand: true,
                size: ZolyaButtonSize.lg,
              )
            else
              Center(
                child: Text(
                  'This delivery is closed.',
                  style: ZolyaTypography.body.copyWith(color: mutedColor),
                ),
              ),
            const SizedBox(height: ZolyaSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({
    required this.pickup,
    required this.dropoff,
    required this.dropoffNeighborhood,
    required this.scheme,
    required this.mutedColor,
    required this.isLight,
  });
  final String pickup;
  final String dropoff;
  final String dropoffNeighborhood;
  final ColorScheme scheme;
  final Color mutedColor;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Column(
        children: [
          _RoutePoint(
            icon: LucideIcons.packageOpen,
            label: 'Pickup',
            value: pickup,
            color: scheme.primary,
            mutedColor: mutedColor,
            scheme: scheme,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs),
            child: Row(
              children: [
                const SizedBox(width: 7),
                Container(width: 2, height: 22, color: mutedColor),
              ],
            ),
          ),
          _RoutePoint(
            icon: LucideIcons.mapPin,
            label: 'Dropoff · $dropoffNeighborhood',
            value: dropoff,
            color: scheme.error,
            mutedColor: mutedColor,
            scheme: scheme,
          ),
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.mutedColor,
    required this.scheme,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: ZolyaSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: ZolyaTypography.label.copyWith(color: mutedColor),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: ZolyaTypography.body.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.mutedColor});
  final String title;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          ZolyaTypography.label.copyWith(color: mutedColor, letterSpacing: 1),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.role,
    required this.name,
    required this.phone,
    required this.scheme,
    required this.mutedColor,
    required this.isLight,
  });
  final IconData icon;
  final String role;
  final String name;
  final String phone;
  final ColorScheme scheme;
  final Color mutedColor;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: scheme.primary),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: ZolyaTypography.label.copyWith(color: mutedColor),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: ZolyaTypography.subtitle
                      .copyWith(color: scheme.onSurface),
                ),
                Text(
                  phone,
                  style: ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.phone, size: 18, color: scheme.primary),
        ],
      ),
    );
  }
}
