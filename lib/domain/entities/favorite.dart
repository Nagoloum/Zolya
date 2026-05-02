import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String userId;
  final String itemId;
  final DateTime createdAt;

  const Favorite({
    required this.userId,
    required this.itemId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [userId, itemId];
}
