import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/utils/platform_utils.dart';
import '../../../theme/zolya_theme.dart';

/// Surface en verre **adaptative** selon la plateforme :
///
///  - **iOS → Liquid Glass** : flou intense, sur-saturation, reflet spéculaire
///    en diagonale, bordure fine très lumineuse, coins très arrondis. Imite le
///    matériau « Liquid Glass » d'Apple (iOS 26).
///  - **Android → Glassmorphism** : flou modéré « givré », teinte translucide
///    douce, bordure subtile. Style Material moderne.
///
/// La plateforme est résolue via [PlatformUtils.of] : en forçant
/// `--dart-define=FORCE_PLATFORM=ios`, on obtient le rendu iPhone sur Windows.
///
/// Exemple :
/// ```dart
/// ZolyaGlass(
///   padding: const EdgeInsets.all(ZolyaSpacing.xl),
///   onTap: () {},
///   child: Text('Bonjour'),
/// )
/// ```
class ZolyaGlass extends StatelessWidget {
  const ZolyaGlass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(ZolyaSpacing.lg),
    this.borderRadius,
    this.onTap,
    this.tint,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsets padding;

  /// Rayon des coins. Si null, dépend de la plateforme (plus arrondi sur iOS).
  final BorderRadius? borderRadius;

  /// Rend la carte tappable avec un effet d'enfoncement.
  final VoidCallback? onTap;

  /// Teinte facultative mélangée au verre (par défaut : couleur de marque selon
  /// le mode clair/sombre).
  final Color? tint;

  /// Ajoute une ombre portée (utile pour les cartes flottantes / FAB).
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final isIOS = PlatformUtils.isIOS(context);
    final dark = Theme.of(context).brightness == Brightness.dark;

    final radius = borderRadius ??
        BorderRadius.circular(isIOS ? ZolyaRadius.xl + 4 : ZolyaRadius.lg);

    // --- Paramètres par plateforme -----------------------------------------
    // iOS pousse le flou et la luminosité ; Android reste plus discret.
    final double blurSigma = isIOS ? 28 : 14;
    final double tintOpacity = dark
        ? (isIOS ? 0.22 : 0.30)
        : (isIOS ? 0.16 : 0.26);
    final double borderOpacity = dark ? 0.30 : (isIOS ? 0.65 : 0.50);
    final double borderWidth = isIOS ? 1.0 : 1.2;

    final baseTint = tint ??
        (dark ? Colors.white : ZolyaColors.blanc);

    Widget content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        // saturation > 1 sur iOS => effet « vibrant » du liquid glass.
        filter: isIOS
            ? ImageFilter.compose(
                outer: ColorFilter.matrix(_saturationMatrix(1.6)),
                inner: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              )
            : ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            // Léger dégradé vertical pour donner du volume au verre.
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseTint.withValues(alpha: tintOpacity + 0.06),
                baseTint.withValues(alpha: tintOpacity),
              ],
            ),
            border: Border.all(
              color: (dark ? Colors.white : Colors.white)
                  .withValues(alpha: borderOpacity),
              width: borderWidth,
            ),
          ),
          child: Stack(
            children: [
              // Reflet spéculaire diagonal — signature du liquid glass iOS.
              if (isIOS)
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: radius,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Colors.white.withValues(alpha: 0.35),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(padding: padding, child: child),
            ],
          ),
        ),
      ),
    );

    if (elevated) {
      content = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.45 : 0.12),
              blurRadius: isIOS ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: content,
      );
    }

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        splashColor: Colors.white.withValues(alpha: 0.12),
        highlightColor: Colors.white.withValues(alpha: 0.06),
        child: content,
      ),
    );
  }

  /// Matrice de saturation 5x4 pour [ColorFilter.matrix].
  static List<double> _saturationMatrix(double s) {
    const double lumR = 0.2126, lumG = 0.7152, lumB = 0.0722;
    final double sr = (1 - s) * lumR;
    final double sg = (1 - s) * lumG;
    final double sb = (1 - s) * lumB;
    return <double>[
      sr + s, sg, sb, 0, 0,
      sr, sg + s, sb, 0, 0,
      sr, sg, sb + s, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
}
