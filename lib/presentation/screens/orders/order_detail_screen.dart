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
                onPressed: () {},
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
