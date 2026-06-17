import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/dev/glass_demo_screen.dart';

/// Point d'entrée ISOLÉ pour tester l'interface verre, sans router ni DI.
///
/// Prévisualiser le rendu iPhone (liquid glass) sur Windows/Chrome :
///   flutter run -t lib/main_glass_demo.dart -d chrome --dart-define=FORCE_PLATFORM=ios
///
/// Prévisualiser le rendu Android (glassmorphism) :
///   flutter run -t lib/main_glass_demo.dart -d chrome --dart-define=FORCE_PLATFORM=android
///
/// Sur l'émulateur Android réel (rendu natif Android) :
///   flutter run -t lib/main_glass_demo.dart
void main() {
  const forced = String.fromEnvironment('FORCE_PLATFORM');
  if (forced == 'ios') {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  } else if (forced == 'android') {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }

  runApp(const _GlassDemoApp());
}

class _GlassDemoApp extends StatelessWidget {
  const _GlassDemoApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Zolya — Glass Demo',
      debugShowCheckedModeBanner: false,
      home: GlassDemoScreen(),
    );
  }
}
