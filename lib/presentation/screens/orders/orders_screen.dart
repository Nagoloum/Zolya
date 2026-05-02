import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/order.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

enum _OrderTab { buyer, seller }

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  _OrderTab _tab = _OrderTab.buyer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(
        title: 'My orders',
        showBack: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          child: Column(
            children: [
              ZolyaSegmentedControl<_OrderTab>(
                value: _tab,
                segments: const [
                  ZolyaSegment(value: _OrderTab.buyer, label: 'Purchases'),
                  ZolyaSegment(value: _OrderTab.seller, label: 'Sales'),
                ],
                onChanged: (v) => setState(() => _tab = v),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              Expanded(
                child: IndexedStack(
                  index: _tab.index,
                  children: [
                    _OrdersList(
                      orders: FakeData.myPurchases,
                      emptyTitle: 'No purchases yet',
                      emptyBody: 'Your purchases will appear here.',
                      l: l,
                    ),
                    _OrdersList(
                      orders: FakeData.mySales,
                      emptyTitle: 'No sales yet',
                      emptyBody: 'Your sales will appear here.',
                      l: l,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({
    required this.orders,
    required this.emptyTitle,
    required this.emptyBody,
    required this.l,
  });
  final List<Order> orders;
  final String emptyTitle;
  final String emptyBody;
  final dynamic l;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return ZolyaEmptyState(
        icon: LucideIcons.receiptText,
        title: emptyTitle,
        body: emptyBody,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.xl),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: ZolyaSpacing.md),
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final Order order;

  String _statusLabel(BuildContext context) {
    final l = context.l10n;
    return switch (order.status) {
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

  ZolyaBadgeVariant _statusVariant() {
    return switch (order.status) {
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
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(RouteNames.orderDetailPath(order.id)),
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        child: Container(
          padding: const EdgeInsets.all(ZolyaSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ZolyaRadius.sm),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: order.productImageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: order.productImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: placeholderColor),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '#${order.orderNumber}',
                          style: ZolyaTypography.bodySmall
                              .copyWith(color: mutedColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          order.createdAt.timeAgo,
                          style: ZolyaTypography.label
                              .copyWith(color: mutedColor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.price(order.totalAmount),
                    style: ZolyaTypography.subtitle
                        .copyWith(color: scheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: ZolyaBadge(
                  label: _statusLabel(context),
                  variant: _statusVariant(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
