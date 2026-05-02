abstract class AppConstants {
  static const String appName = 'Zolya';
  static const String currency = 'FCFA';
  static const String currencySymbol = 'F';
  static const String phonePrefix = '+237';

  static const double zolyaCommissionRate = 0.15;

  static const int deliveryZone1Fee = 1500;
  static const int deliveryZone2Fee = 1000;
  static const int deliveryZone3Fee = 2000;

  static const int deliveryPayPerRide = 500;
  static const String deliveryPayDay = 'Vendredi';

  static const int otpLength = 6;
  static const int otpExpiryMinutes = 5;
  static const int otpResendCooldown = 60;

  static const int defaultPageSize = 20;

  static const int maxProductImages = 6;
  static const int maxProductVideoSeconds = 30;
  static const double maxImageSizeMb = 5.0;

  static const int cacheMaxAgeDays = 7;

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'current_user';

  static const int snackbarShortMs = 2000;
  static const int snackbarLongMs = 4000;
}
