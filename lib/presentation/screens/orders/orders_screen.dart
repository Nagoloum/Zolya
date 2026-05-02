import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              Expanded(
                child: IndexedStack(
                  index: _tab.index,
                  children: const [
                    ZolyaEmptyState(
                      icon: LucideIcons.receiptText,
                      title: 'No purchases yet',
                      body: 'Your purchases will appear here.',
                    ),
                    ZolyaEmptyState(
                      icon: LucideIcons.receiptText,
                      title: 'No sales yet',
                      body: 'Your sales will appear here.',
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
