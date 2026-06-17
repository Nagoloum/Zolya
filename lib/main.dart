import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Permet de PRÉVISUALISER l'interface iPhone/Android sur n'importe quel
  // appareil (utile sur Windows où le simulateur iOS n'existe pas).
  //   flutter run --dart-define=FORCE_PLATFORM=ios
  //   flutter run --dart-define=FORCE_PLATFORM=android
  const forced = String.fromEnvironment('FORCE_PLATFORM');
  if (forced == 'ios') {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  } else if (forced == 'android') {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await configureDependencies();

  runApp(const ZolyaApp());
}
