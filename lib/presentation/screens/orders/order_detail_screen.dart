import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/extensions/date_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/order.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  Order _resolveOrder() {
    return FakeData.myPurchases.firstWhere(
      (o) => o.id == orderId,
      orElse: () => FakeData.myPurchases.first,
    );
  }

  String _statusLabel(BuildContext context, OrderStatus status) {
    final l = context.l10n;
    return switch (status) {
      OrderStatus.pendingPayment => l.orderStatusPlaced,
      OrderStatus.paid => l.orderStatusPaid,
      OrderStatus.awaitingCourier ||
      OrderStatus.assignedToDeliverer ||
      OrderStatus.pickedUp ||
      OrderStatus.inDelivery =>
        l.orderStatusInDelivery,
      OrderStatus.delivered => l.orderStatusDelivered,
      OrderStatus.cancelled || OrderStatus.refunded || OrderStatus.disputed =>
        l.orderStatusCancelled,
    };
  }

  ZolyaBadgeVariant _statusVariant(OrderStatus status) {
    return switch (status) {
      OrderStatus.delivered => ZolyaBadgeVariant.success,
      OrderStatus.cancelled || OrderStatus.refunded => ZolyaBadgeVariant.error,
      OrderStatus.disputed => ZolyaBadgeVariant.warning,
      _ => ZolyaBadgeVariant.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;
    final order = _resolveOrder();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(
        title: '#${order.orderNumber}',
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          children: [
            _ProductCard(order: order),
            const SizedBox(height: ZolyaSpacing.xl),
            _SectionTitle(title: l.orderDetailStatus, mutedColor: mutedColor),
            const SizedBox(height: ZolyaSpacing.sm),
            ZolyaBadge(
              label: _statusLabel(context, order.status),
              variant: _statusVariant(order.status),
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _InfoBlock(
              rows: [
                _InfoRow(
                  icon: LucideIcons.hash,
                  label: l.orderDetailNumber,
                  value: order.orderNumber,
                ),
                _InfoRow(
                  icon: LucideIcons.calendar,
                  label: l.orderDetailDate,
                  value: order.createdAt.timeAgo,
                ),
              ],
              mutedColor: mutedColor,
              scheme: scheme,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _SectionTitle(
              title: l.orderDetailDeliveryAddress,
              mutedColor: mutedColor,
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            _InfoBlock(
              rows: [
                _InfoRow(
                  icon: LucideIcons.mapPin,
                  label: order.deliveryAddress.neighborhood,
                  value: order.deliveryAddress.street,
                ),
                _InfoRow(
                  icon: LucideIcons.phone,
                  label: l.aboutPhone,
                  value: order.deliveryAddress.phone,
                ),
              ],
              mutedColor: mutedColor,
              scheme: scheme,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            _SectionTitle(title: l.orderDetailSummary, mutedColor: mutedColor),
            const SizedBox(height: ZolyaSpacing.sm),
            _SummaryRow(
              label: l.orderDetailSubtotal,
              value: Formatters.price(order.articlePrice),
              mutedColor: mutedColor,
              scheme: scheme,
            ),
            _SummaryRow(
              label: l.orderDetailDelivery,
              value: Formatters.price(order.deliveryFee),
              mutedColor: mutedColor,
              scheme: scheme,
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            const Divider(thickness: 0.5),
            const SizedBox(height: ZolyaSpacing.sm),
            _SummaryRow(
              label: l.orderDetailTotal,
              value: Formatters.price(order.totalAmount),
              mutedColor: mutedColor,
              scheme: scheme,
              highlight: true,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            if (order.status != OrderStatus.delivered &&
                order.status != OrderStatus.cancelled)
              ZolyaButton(
                label: l.orderDetailTrackOrder,
                leading: const Icon(LucideIcons.truck, size: 18),
                onPressed: () => _OrderTrackingSheet.show(context, order),
                expand: true,
                size: ZolyaButtonSize.lg,
              ),
            const SizedBox(height: ZolyaSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Container(
      padding: const EdgeInsets.all(ZolyaSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ZolyaRadius.sm),
            child: SizedBox(
              width: 64,
              height: 64,
              child: order.productImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: order.productImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: placeholderColor),
                      errorWidget: (_, __, ___) =>
                          Container(color: placeholderColor),
                    )
                  : Container(color: placeholderColor),
            ),
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  order.productTitle,
                  style: ZolyaTypography.subtitle
                      .copyWith(color: scheme.onSurface),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  Formatters.price(order.articlePrice),
                  style: ZolyaTypography.body.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
        ],
      ),
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
      title.toUpperCase(),
      style:
          ZolyaTypography.label.copyWith(color: mutedColor, letterSpacing: 1),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.rows,
    required this.mutedColor,
    required this.scheme,
  });
  final List<_InfoRow> rows;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ZolyaSpacing.md,
        vertical: ZolyaSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            rows[i].build(context, mutedColor, scheme),
            if (i < rows.length - 1) const Divider(thickness: 0.5, height: 12),
          ],
        ],
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  Widget build(
    BuildContext context,
    Color mutedColor,
    ColorScheme scheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 16, color: mutedColor),
          const SizedBox(width: ZolyaSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: ZolyaTypography.body.copyWith(color: mutedColor),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: ZolyaTypography.body.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Une étape du suivi de livraison.
class _TrackStep {
  const _TrackStep({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class _OrderTrackingSheet extends StatelessWidget {
  const _OrderTrackingSheet({required this.order});
  final Order order;

  static Future<void> show(BuildContext context, Order order) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _OrderTrackingSheet(order: order),
    );
  }

  /// Indice de l'étape atteinte (les étapes <= currentStep sont validées).
  int _currentStep(OrderStatus status) {
    return switch (status) {
      OrderStatus.pendingPayment => 0,
      OrderStatus.paid => 0,
      OrderStatus.awaitingCourier || OrderStatus.assignedToDeliverer => 1,
      OrderStatus.pickedUp || OrderStatus.inDelivery => 2,
      OrderStatus.delivered => 3,
      OrderStatus.cancelled ||
      OrderStatus.refunded ||
      OrderStatus.disputed =>
        0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    final steps = <_TrackStep>[
      _TrackStep(label: l.orderStatusPaid, icon: LucideIcons.creditCard),
      _TrackStep(label: l.orderTrackingPreparing, icon: LucideIcons.package),
      _TrackStep(label: l.orderStatusInDelivery, icon: LucideIcons.truck),
      _TrackStep(label: l.orderStatusDelivered, icon: LucideIcons.circleCheck),
    ];
    final current = _currentStep(order.status);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(ZolyaRadius.lg),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          ZolyaSpacing.lg,
          ZolyaSpacing.md,
          ZolyaSpacing.lg,
          ZolyaSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: mutedColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            Text(
              l.orderTrackingTitle,
              style: ZolyaTypography.title.copyWith(color: scheme.onSurface),
            ),
            const SizedBox(height: ZolyaSpacing.xs),
            Text(
              '#${order.orderNumber}',
              style: ZolyaTypography.body.copyWith(color: mutedColor),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            for (var i = 0; i < steps.length; i++)
              _TrackStepRow(
                step: steps[i],
                done: i <= current,
                active: i == current,
                isLast: i == steps.length - 1,
                scheme: scheme,
                mutedColor: mutedColor,
              ),
            const SizedBox(height: ZolyaSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _TrackStepRow extends StatelessWidget {
  const _TrackStepRow({
    required this.step,
    required this.done,
    required this.active,
    required this.isLast,
    required this.scheme,
    required this.mutedColor,
  });
  final _TrackStep step;
  final bool done;
  final bool active;
  final bool isLast;
  final ColorScheme scheme;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final dotColor = done ? scheme.primary : scheme.surfaceContainerHighest;
    final iconColor = done ? scheme.onPrimary : mutedColor;
    final labelColor = done ? scheme.onSurface : mutedColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(step.icon, size: 18, color: iconColor),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: done ? scheme.primary : scheme.surfaceContainerHighest,
                  ),
                ),
            ],
          ),
          const SizedBox(width: ZolyaSpacing.md),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: ZolyaSpacing.md),
            child: Text(
              step.label,
              style: (active
                      ? ZolyaTypography.subtitle
                      : ZolyaTypography.body)
                  .copyWith(
                color: labelColor,
                fontWeight: active ? FontWeight.w700 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.mutedColor,
    required this.scheme,
    this.highlight = false,
  });
  final String label;
  final String value;
  final Color mutedColor;
  final ColorScheme scheme;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final labelStyle = highlight
        ? ZolyaTypography.subtitle.copyWith(color: scheme.onSurface)
        : ZolyaTypography.body.copyWith(color: mutedColor);
    final valueStyle = highlight
        ? ZolyaTypography.title.copyWith(color: scheme.primary)
        : ZolyaTypography.body.copyWith(color: scheme.onSurface);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.xs + 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
