import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/delivery.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

enum _DeliveryTab { available, mine }

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  _DeliveryTab _tab = _DeliveryTab.available;

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(
        title: 'Courier',
        showBack: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ZolyaSegmentedControl<_DeliveryTab>(
                value: _tab,
                segments: const [
                  ZolyaSegment(
                      value: _DeliveryTab.available, label: 'Available'),
                  ZolyaSegment(
                      value: _DeliveryTab.mine, label: 'My deliveries'),
                ],
                onChanged: (v) => setState(() => _tab = v),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              Expanded(
                child: IndexedStack(
                  index: _tab.index,
                  children: [
                    _AvailableDeliveriesView(onRefresh: _refresh),
                    _MyDeliveriesView(onRefresh: _refresh),
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

class _AvailableDeliveriesView extends StatelessWidget {
  const _AvailableDeliveriesView({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final available = FakeData.availableDeliveries
        .where((d) => d.status == DeliveryStatus.available)
        .toList(growable: false);

    if (available.isEmpty) {
      return const ZolyaEmptyState(
        icon: LucideIcons.truck,
        title: 'No deliveries available',
        body:
            'Available rides will appear here as soon as a client orders one.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: available.length,
      separatorBuilder: (_, __) => const SizedBox(height: ZolyaSpacing.md),
      itemBuilder: (_, i) => _DeliveryCard(
        delivery: available[i],
        onRefresh: onRefresh,
      ),
    );
  }
}

class _MyDeliveriesView extends StatelessWidget {
  const _MyDeliveriesView({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final mine = FakeData.myDeliveries;
    final completed = mine
        .where((d) => d.status == DeliveryStatus.completed)
        .length;
    final earnings =
        mine.where((d) => d.status == DeliveryStatus.completed).fold<int>(
              0,
              (sum, d) => sum + d.fee,
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EarningsCard(weeklyEarnings: earnings, deliveryCount: completed),
        const SizedBox(height: ZolyaSpacing.xl),
        Expanded(
          child: mine.isEmpty
              ? const ZolyaEmptyState(
                  icon: LucideIcons.truck,
                  title: 'No deliveries this week',
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: mine.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: ZolyaSpacing.md),
                  itemBuilder: (_, i) => _DeliveryCard(
                    delivery: mine[i],
                    onRefresh: onRefresh,
                  ),
                ),
        ),
      ],
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.delivery, required this.onRefresh});
  final Delivery delivery;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ZolyaRadius.md),
        onTap: () async {
          await context.push(RouteNames.deliveryDetailPath(delivery.id));
          onRefresh();
        },
        child: Container(
          padding: const EdgeInsets.all(ZolyaSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(ZolyaRadius.md),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${delivery.orderId}',
                    style: ZolyaTypography.subtitle
                        .copyWith(color: scheme.onSurface),
                  ),
                  Text(
                    '${Formatters.price(delivery.fee)} fee',
                    style: ZolyaTypography.subtitle.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              _CardLine(
                icon: LucideIcons.packageOpen,
                text: delivery.pickupAddress,
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              const SizedBox(height: 4),
              _CardLine(
                icon: LucideIcons.mapPin,
                text: delivery.dropoffAddress,
                mutedColor: mutedColor,
                scheme: scheme,
              ),
              const SizedBox(height: ZolyaSpacing.sm),
              ZolyaBadge(
                label: delivery.statusLabel,
                variant: delivery.status == DeliveryStatus.completed
                    ? ZolyaBadgeVariant.success
                    : delivery.status == DeliveryStatus.available
                        ? ZolyaBadgeVariant.warning
                        : ZolyaBadgeVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardLine extends StatelessWidget {
  const _CardLine({
    required this.icon,
    required this.text,
    required this.mutedColor,
    required this.scheme,
  });
  final IconData icon;
  final String text;
  final Color mutedColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: mutedColor),
        const SizedBox(width: ZolyaSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: ZolyaTypography.bodySmall.copyWith(color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _EarningsCard extends StatelessWidget {
  const _EarningsCard({
    required this.weeklyEarnings,
    required this.deliveryCount,
  });
  final int weeklyEarnings;
  final int deliveryCount;

  @override
  Widget build(BuildContext context) {
    return ZolyaGradientCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(
            value: Formatters.price(weeklyEarnings),
            label: 'Weekly earnings',
          ),
          Container(width: 1, height: 40, color: ZolyaColors.noir.withValues(alpha: 0.15)),
          _Stat(value: '$deliveryCount', label: 'Deliveries'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: ZolyaTypography.headline.copyWith(
            color: ZolyaColors.noir,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ZolyaTypography.label
              .copyWith(color: ZolyaColors.noir.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}
