extension StringExtensions on String {
  bool get isValidPhone {
    final phone = replaceAll(RegExp(r'\s+|-'), '');
    return RegExp(r'^(\+237)?[6-9]\d{8}$').hasMatch(phone);
  }

  bool get isValidPassword => length >= 8;

  bool get isNotBlank => trim().isNotEmpty;

  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get titleCase {
    return split(' ').map((w) => w.capitalized).join(' ');
  }

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  String formatPhone() {
    final digits = replaceAll(RegExp(r'\D'), '');
    if (digits.length == 9) {
      return '+237 ${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }
    return this;
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
