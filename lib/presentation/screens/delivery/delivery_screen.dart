import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/utils/formatters.dart';
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
                  children: const [
                    _AvailableDeliveriesView(),
                    _MyDeliveriesView(),
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
  const _AvailableDeliveriesView();

  @override
  Widget build(BuildContext context) {
    return const ZolyaEmptyState(
      icon: LucideIcons.truck,
      title: 'No deliveries available',
      body: 'Available rides will appear here as soon as a client orders one.',
    );
  }
}

class _MyDeliveriesView extends StatelessWidget {
  const _MyDeliveriesView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EarningsCard(weeklyEarnings: 0, deliveryCount: 0),
        SizedBox(height: ZolyaSpacing.xl),
        Expanded(
          child: ZolyaEmptyState(
            icon: LucideIcons.truck,
            title: 'No deliveries this week',
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
