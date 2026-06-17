import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Détection de plateforme centralisée pour piloter l'UI adaptative.
///
/// On s'appuie sur [defaultTargetPlatform] / `Theme.of(context).platform`
/// plutôt que sur `dart:io Platform`, pour deux raisons :
///   1. Ça fonctionne aussi sur le web (où `Platform` lève une exception).
///   2. Ça respecte `debugDefaultTargetPlatformOverride`, ce qui permet de
///      PRÉVISUALISER l'interface iPhone sur Windows / Chrome / Android.
///
/// Active la prévisualisation iOS avec :
///   flutter run -d chrome --dart-define=FORCE_PLATFORM=ios
class PlatformUtils {
  PlatformUtils._();

  /// Plateforme cible effective (tient compte de l'override de debug).
  static TargetPlatform of(BuildContext context) => Theme.of(context).platform;

  static bool isIOS(BuildContext context) =>
      of(context) == TargetPlatform.iOS;

  static bool isAndroid(BuildContext context) =>
      of(context) == TargetPlatform.android;

  /// `true` quand l'app doit adopter le langage visuel Apple
  /// (liquid glass, Cupertino, swipe-back).
  static bool useCupertino(BuildContext context) => isIOS(context);

  /// Sans contexte (ex. dans `main`) — utile pour configurer l'override.
  static bool get isIOSGlobal => defaultTargetPlatform == TargetPlatform.iOS;
}
