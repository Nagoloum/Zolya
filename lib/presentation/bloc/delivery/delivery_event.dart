import 'package:equatable/equatable.dart';
import '../../../domain/entities/delivery.dart';

abstract class DeliveryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryLoadAvailableRequested extends DeliveryEvent {}

class DeliveryLoadMyDeliveriesRequested extends DeliveryEvent {}

class DeliveryAcceptRequested extends DeliveryEvent {
  final String deliveryId;
  DeliveryAcceptRequested({required this.deliveryId});
  @override
  List<Object?> get props => [deliveryId];
}

class DeliveryStatusUpdateRequested extends DeliveryEvent {
  final String deliveryId;
  final DeliveryStatus status;
  DeliveryStatusUpdateRequested({required this.deliveryId, required this.status});
  @override
  List<Object?> get props => [deliveryId, status];
}

class DeliveryLoadEarningsRequested extends DeliveryEvent {}
