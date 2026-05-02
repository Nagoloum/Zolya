abstract class Validators {

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Numéro requis';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 9) return '9 chiffres attendus';
    if (!digits.startsWith('6')) return 'Doit commencer par 6';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe requis';
    if (value.length < 8) return 'Minimum 8 caractères';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Confirmation requise';
    if (value != original) return 'Les mots de passe ne correspondent pas';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nom complet requis';
    if (value.trim().length < 3) return 'Nom trop court';
    return null;
  }

  static String? required(String? value, {String label = 'Ce champ'}) {
    if (value == null || value.trim().isEmpty) return '$label est requis';
    return null;
  }

  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) return 'Prix requis';
    final parsed = int.tryParse(value.replaceAll(RegExp(r'\s'), ''));
    if (parsed == null || parsed <= 0) return 'Prix invalide';
    if (parsed < 500) return 'Prix minimum: 500 FCFA';
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.length != 6) return 'Code OTP à 6 chiffres requis';
    if (!RegExp(r'^\d{6}$').hasMatch(value)) return 'Code OTP invalide';
    return null;
  }
}
