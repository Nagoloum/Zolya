import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) return 'À l\'instant';
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours}h';
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} jours';
    return DateFormat('dd MMM yyyy', 'fr').format(this);
  }

  String get formatted => DateFormat('dd/MM/yyyy', 'fr').format(this);
  String get formattedWithTime => DateFormat('dd/MM/yyyy à HH:mm', 'fr').format(this);
  String get dayMonth => DateFormat('dd MMM', 'fr').format(this);
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
