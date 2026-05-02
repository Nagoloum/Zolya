import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const ZolyaTopBar(
            title: 'Mon profil',
            showBack: false,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.lg,
              vertical: ZolyaSpacing.lg,
            ),
            children: [
              _Header(name: user?.fullName ?? '—', phone: user?.phone ?? '—')
                  .animate()
                  .fadeIn(duration: 250.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              _WalletCard(balance: user?.walletBalance ?? 0)
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 250.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              _MenuItem(
                icon: LucideIcons.store,
                label: 'Mes articles',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.history,
                label: 'Historique',
                onTap: () {},
              ),
              _MenuItem(
                icon: LucideIcons.settings,
                label: 'Paramètres',
                onTap: () => context.push(RouteNames.settings),
              ),
              const SizedBox(height: ZolyaSpacing.lg),
              const Divider(thickness: 0.5),
              const SizedBox(height: ZolyaSpacing.sm),
              _MenuItem(
                icon: LucideIcons.logOut,
                label: 'Se déconnecter',
                color: Theme.of(context).colorScheme.error,
                onTap: () =>
                    context.read<AuthBloc>().add(AuthLogoutRequested()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.name, required this.phone});
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Center(
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ZolyaAvatar(name: name, size: ZolyaAvatarSize.xl),
          ),
          const SizedBox(height: ZolyaSpacing.md),
          Text(
            name,
            style: ZolyaTypography.headline.copyWith(color: scheme.onSurface),
          ),
          const SizedBox(height: ZolyaSpacing.xs / 2),
          Text(
            phone,
            style: ZolyaTypography.body.copyWith(color: mutedColor),
          ),
        ],
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.balance});
  final int balance;

  @override
  Widget build(BuildContext context) {
    const onGradientColor = ZolyaColors.noir;
    return ZolyaGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.wallet, color: onGradientColor, size: 18),
              const SizedBox(width: ZolyaSpacing.sm),
              Text(
                'Portefeuille',
                style: ZolyaTypography.bodySmall.copyWith(
                  color: onGradientColor.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: ZolyaSpacing.sm),
          Text(
            Formatters.price(balance),
            style: ZolyaTypography.displayMedium.copyWith(
              color: onGradientColor,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: ZolyaSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: onGradientColor),
              icon: const Icon(LucideIcons.arrowUpRight, size: 16),
              label: Text(
                'Retrait',
                style: ZolyaTypography.button.copyWith(color: onGradientColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final chevronColor = isLight ? ZolyaColors.texte3 : ZolyaColors.texte3Dark;
    final c = color ?? scheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZolyaRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: ZolyaSpacing.md + 2),
          child: Row(
            children: [
              Icon(icon, color: c, size: 20),
              const SizedBox(width: ZolyaSpacing.md),
              Expanded(
                child:
                    Text(label, style: ZolyaTypography.body.copyWith(color: c)),
              ),
              if (color == null)
                Icon(LucideIcons.chevronRight, color: chevronColor, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
