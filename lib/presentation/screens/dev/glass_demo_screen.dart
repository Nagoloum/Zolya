import 'package:flutter/material.dart';

import '../../../core/utils/platform_utils.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya_glass.dart';

/// Écran de démonstration du verre adaptatif.
///
/// Sur iOS → liquid glass ; sur Android → glassmorphism.
/// Lance-le isolément avec `lib/main_glass_demo.dart`.
class GlassDemoScreen extends StatelessWidget {
  const GlassDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = PlatformUtils.isIOS(context);

    return Scaffold(
      // Un fond imagé/coloré est indispensable pour VOIR l'effet de verre :
      // le flou doit avoir quelque chose à flouter.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3A1C71),
              Color(0xFFD76D77),
              Color(0xFFFFAF7B),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Quelques blobs colorés derrière le verre pour le relief.
            const Positioned(top: 80, left: -40, child: _Blob(ZolyaColors.or)),
            const Positioned(
                bottom: 120, right: -30, child: _Blob(Color(0xFF22D3EE))),
            SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(ZolyaSpacing.lg),
                children: [
                  Text(
                    isIOS ? 'iPhone · Liquid Glass' : 'Android · Glassmorphism',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xs),
                  Text(
                    'Plateforme détectée : ${PlatformUtils.of(context).name}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),

                  // Carte de verre simple
                  ZolyaGlass(
                    padding: const EdgeInsets.all(ZolyaSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Carte en verre',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: ZolyaSpacing.sm),
                        Text(
                          'Le matériau s\'adapte : reflet spéculaire + sur-saturation '
                          'sur iOS, givré plus discret sur Android.',
                          style: TextStyle(color: Colors.white70, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.lg),

                  // Carte tappable + ombre
                  ZolyaGlass(
                    elevated: true,
                    onTap: () {},
                    padding: const EdgeInsets.all(ZolyaSpacing.xl),
                    child: Row(
                      children: const [
                        Icon(Icons.shopping_bag_outlined,
                            color: Colors.white, size: 28),
                        SizedBox(width: ZolyaSpacing.lg),
                        Expanded(
                          child: Text('Carte cliquable avec ombre portée',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Icon(Icons.chevron_right, color: Colors.white70),
                      ],
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.lg),

                  // Rangée de petites tuiles
                  Row(
                    children: [
                      Expanded(
                          child: ZolyaGlass(
                              padding:
                                  const EdgeInsets.all(ZolyaSpacing.lg),
                              child: const _Tile(
                                  icon: Icons.favorite_border,
                                  label: 'Favoris'))),
                      const SizedBox(width: ZolyaSpacing.md),
                      Expanded(
                          child: ZolyaGlass(
                              padding:
                                  const EdgeInsets.all(ZolyaSpacing.lg),
                              child: const _Tile(
                                  icon: Icons.wallet_outlined,
                                  label: 'Wallet'))),
                    ],
                  ),
                ],
              ),
            ),

            // Barre de navigation flottante en verre (style iOS / Android).
            Positioned(
              left: ZolyaSpacing.lg,
              right: ZolyaSpacing.lg,
              bottom: ZolyaSpacing.xl,
              child: ZolyaGlass(
                elevated: true,
                borderRadius: BorderRadius.circular(ZolyaRadius.full),
                padding: const EdgeInsets.symmetric(
                    horizontal: ZolyaSpacing.xl, vertical: ZolyaSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.home_filled, color: Colors.white),
                    Icon(Icons.search, color: Colors.white70),
                    Icon(Icons.add_circle_outline, color: Colors.white70),
                    Icon(Icons.notifications_none, color: Colors.white70),
                    Icon(Icons.person_outline, color: Colors.white70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: ZolyaSpacing.sm),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.55),
      ),
    );
  }
}
