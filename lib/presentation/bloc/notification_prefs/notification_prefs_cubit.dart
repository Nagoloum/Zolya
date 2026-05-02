import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPrefs {
  const NotificationPrefs({
    this.general = true,
    this.sound = true,
    this.vibrate = false,
    this.specialOffers = true,
    this.promoDiscounts = false,
    this.payments = false,
    this.cashback = true,
    this.appUpdates = false,
    this.newService = true,
    this.newTips = false,
  });

  final bool general;
  final bool sound;
  final bool vibrate;
  final bool specialOffers;
  final bool promoDiscounts;
  final bool payments;
  final bool cashback;
  final bool appUpdates;
  final bool newService;
  final bool newTips;

  NotificationPrefs copyWith({
    bool? general,
    bool? sound,
    bool? vibrate,
    bool? specialOffers,
    bool? promoDiscounts,
    bool? payments,
    bool? cashback,
    bool? appUpdates,
    bool? newService,
    bool? newTips,
  }) {
    return NotificationPrefs(
      general: general ?? this.general,
      sound: sound ?? this.sound,
      vibrate: vibrate ?? this.vibrate,
      specialOffers: specialOffers ?? this.specialOffers,
      promoDiscounts: promoDiscounts ?? this.promoDiscounts,
      payments: payments ?? this.payments,
      cashback: cashback ?? this.cashback,
      appUpdates: appUpdates ?? this.appUpdates,
      newService: newService ?? this.newService,
      newTips: newTips ?? this.newTips,
    );
  }

  Map<String, bool> toMap() => {
        'general': general,
        'sound': sound,
        'vibrate': vibrate,
        'specialOffers': specialOffers,
        'promoDiscounts': promoDiscounts,
        'payments': payments,
        'cashback': cashback,
        'appUpdates': appUpdates,
        'newService': newService,
        'newTips': newTips,
      };
}

class NotificationPrefsCubit extends Cubit<NotificationPrefs> {
  NotificationPrefsCubit() : super(const NotificationPrefs());

  static const String _prefsKey = 'zolya.notification_prefs';

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = state.toMap();
      final next = NotificationPrefs(
        general: prefs.getBool('$_prefsKey.general') ?? map['general']!,
        sound: prefs.getBool('$_prefsKey.sound') ?? map['sound']!,
        vibrate: prefs.getBool('$_prefsKey.vibrate') ?? map['vibrate']!,
        specialOffers:
            prefs.getBool('$_prefsKey.specialOffers') ?? map['specialOffers']!,
        promoDiscounts: prefs.getBool('$_prefsKey.promoDiscounts') ??
            map['promoDiscounts']!,
        payments: prefs.getBool('$_prefsKey.payments') ?? map['payments']!,
        cashback: prefs.getBool('$_prefsKey.cashback') ?? map['cashback']!,
        appUpdates:
            prefs.getBool('$_prefsKey.appUpdates') ?? map['appUpdates']!,
        newService:
            prefs.getBool('$_prefsKey.newService') ?? map['newService']!,
        newTips: prefs.getBool('$_prefsKey.newTips') ?? map['newTips']!,
      );
      emit(next);
    } catch (_) {}
  }

  Future<void> _save(NotificationPrefs prefs) async {
    try {
      final p = await SharedPreferences.getInstance();
      for (final entry in prefs.toMap().entries) {
        await p.setBool('$_prefsKey.${entry.key}', entry.value);
      }
    } catch (_) {}
  }

  void toggle(String key) {
    NotificationPrefs next = state;
    switch (key) {
      case 'general':
        next = state.copyWith(general: !state.general);
      case 'sound':
        next = state.copyWith(sound: !state.sound);
      case 'vibrate':
        next = state.copyWith(vibrate: !state.vibrate);
      case 'specialOffers':
        next = state.copyWith(specialOffers: !state.specialOffers);
      case 'promoDiscounts':
        next = state.copyWith(promoDiscounts: !state.promoDiscounts);
      case 'payments':
        next = state.copyWith(payments: !state.payments);
      case 'cashback':
        next = state.copyWith(cashback: !state.cashback);
      case 'appUpdates':
        next = state.copyWith(appUpdates: !state.appUpdates);
      case 'newService':
        next = state.copyWith(newService: !state.newService);
      case 'newTips':
        next = state.copyWith(newTips: !state.newTips);
    }
    emit(next);
    _save(next);
  }
}
