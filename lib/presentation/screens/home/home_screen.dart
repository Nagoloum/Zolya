import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/i18n/locale_provider.dart';
import 'widgets/floating_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  static const _tabRoutes = [
    RouteNames.marketplace,
    RouteNames.search,
    RouteNames.orders,
    RouteNames.profile,
  ];

  int _currentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    for (var i = 0; i < _tabRoutes.length; i++) {
      if (location.startsWith(_tabRoutes[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final index = _currentIndex(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      body: child,
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: index,
        onTap: (i) => context.go(_tabRoutes[i]),
        onSellTap: () => context.push(RouteNames.createListing),
        sellIcon: LucideIcons.plus,
        sellTooltip: l.navSell,
        leftTabs: [
          BottomNavTab(icon: LucideIcons.house, label: l.navHome),
          BottomNavTab(icon: LucideIcons.search, label: l.navSearch),
        ],
        rightTabs: [
          BottomNavTab(icon: LucideIcons.receiptText, label: l.navOrders),
          BottomNavTab(icon: LucideIcons.user, label: l.navAccount),
        ],
      ),
    );
  }
}
