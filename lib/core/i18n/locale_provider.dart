import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_strings.dart';
import 'app_strings_en.dart';
import 'app_strings_fr.dart';

enum AppLocale { en, fr }

class LocaleProvider extends StatefulWidget {
  final Widget child;
  final AppLocale initial;

  const LocaleProvider({
    super.key,
    required this.child,
    this.initial = AppLocale.en,
  });

  static const String _prefsKey = 'zolya.locale';

  static _LocaleProviderState _of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_LocaleScope>();
    assert(scope != null, 'LocaleProvider missing above widget tree');
    return scope!.state;
  }

  static void setLocale(BuildContext context, AppLocale locale) {
    _of(context)._setLocale(locale);
  }

  @override
  State<LocaleProvider> createState() => _LocaleProviderState();
}

class _LocaleProviderState extends State<LocaleProvider> {
  late AppLocale _locale = widget.initial;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(LocaleProvider._prefsKey);
      if (raw == null) return;
      final restored = switch (raw) {
        'fr' => AppLocale.fr,
        'en' => AppLocale.en,
        _ => null,
      };
      if (restored != null && restored != _locale && mounted) {
        setState(() => _locale = restored);
      }
    } catch (_) {}
  }

  Future<void> _persist(AppLocale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        LocaleProvider._prefsKey,
        locale == AppLocale.fr ? 'fr' : 'en',
      );
    } catch (_) {}
  }

  void _setLocale(AppLocale locale) {
    if (locale == _locale) return;
    setState(() => _locale = locale);
    _persist(locale);
  }

  AppStrings get _strings => switch (_locale) {
        AppLocale.fr => const AppStringsFr(),
        AppLocale.en => const AppStringsEn(),
      };

  @override
  Widget build(BuildContext context) {
    return _LocaleScope(
      locale: _locale,
      strings: _strings,
      state: this,
      child: widget.child,
    );
  }
}

class _LocaleScope extends InheritedWidget {
  final AppLocale locale;
  final AppStrings strings;
  final _LocaleProviderState state;

  const _LocaleScope({
    required this.locale,
    required this.strings,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_LocaleScope old) => old.locale != locale;
}

extension LocaleContext on BuildContext {

  AppStrings get l10n {
    final scope = dependOnInheritedWidgetOfExactType<_LocaleScope>();
    assert(scope != null, 'LocaleProvider missing — wrap MaterialApp in LocaleProvider');
    return scope!.strings;
  }

  AppLocale get appLocale {
    final scope = dependOnInheritedWidgetOfExactType<_LocaleScope>();
    return scope?.locale ?? AppLocale.en;
  }
}
