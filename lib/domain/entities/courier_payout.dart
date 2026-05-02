import 'package:equatable/equatable.dart';

enum CourierPayoutStatus { pending, paid }

class CourierPayout extends Equatable {
  final String id;
  final String courierId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final int deliveriesCount;
  final int ratePerDelivery;
  final int totalAmount;
  final CourierPayoutStatus status;
  final DateTime? paidAt;

  const CourierPayout({
    required this.id,
    required this.courierId,
    required this.weekStart,
    required this.weekEnd,
    required this.deliveriesCount,
    required this.ratePerDelivery,
    required this.totalAmount,
    this.status = CourierPayoutStatus.pending,
    this.paidAt,
  });

  @override
  List<Object?> get props => [id, courierId, weekStart, status];
}
