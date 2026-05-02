import 'package:flutter/services.dart';

class CameroonPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final clipped = digits.length > 9 ? digits.substring(0, 9) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < clipped.length; i++) {
      if (i == 3 || i == 6) buffer.write(' ');
      buffer.write(clipped[i]);
    }
    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

abstract class CameroonPhone {
  static String normalize(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    return '+237$digits';
  }

  static String displayLocal(String? raw) {
    if (raw == null) return '';
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final local = digits.startsWith('237') ? digits.substring(3) : digits;
    if (local.length != 9) return local;
    return '${local.substring(0, 3)} ${local.substring(3, 6)} ${local.substring(6)}';
  }
}
