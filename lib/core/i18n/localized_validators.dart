import 'app_strings.dart';

class LocalizedValidators {
  final AppStrings l;

  const LocalizedValidators(this.l);

  String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return l.errorPhoneRequired;
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 9) return l.errorPhoneLength;
    if (!digits.startsWith('6')) return l.errorPhonePrefix;
    return null;
  }

  String? password(String? value) {
    if (value == null || value.isEmpty) return l.errorPasswordRequired;
    if (value.length < 8) return l.errorPasswordMinLength;
    return null;
  }

  String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return l.errorFullNameRequired;
    if (value.trim().length < 3) return l.errorFullNameTooShort;
    return null;
  }

  String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return l.errorConfirmRequired;
    if (value != original) return l.errorPasswordsMismatch;
    return null;
  }

  String? otp(String? value, {required int length}) {
    if (value == null || value.length != length) return l.errorOtpInvalid;
    if (!RegExp(r'^\d+$').hasMatch(value)) return l.errorOtpInvalid;
    return null;
  }
}
