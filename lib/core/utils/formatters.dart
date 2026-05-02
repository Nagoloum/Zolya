import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

abstract class Formatters {
  static final _priceFormat = NumberFormat('#,###', 'fr');

  static String price(int amount) {
    return '${_priceFormat.format(amount)} ${AppConstants.currency}';
  }

  static String priceCompact(int amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M ${AppConstants.currencySymbol}';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(0)}k ${AppConstants.currencySymbol}';
    return price(amount);
  }

  static String commission(int salePrice) {
    final commission = (salePrice * AppConstants.zolyaCommissionRate).round();
    return price(commission);
  }

  static String sellerReceives(int salePrice) {
    final commission = (salePrice * AppConstants.zolyaCommissionRate).round();
    return price(salePrice - commission);
  }

  static String phone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 9) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }
    return phone;
  }

  static String orderTotal(int articlePrice, int deliveryFee) {
    return price(articlePrice + deliveryFee);
  }
}
