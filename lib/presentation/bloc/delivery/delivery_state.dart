import 'package:equatable/equatable.dart';
import '../../../domain/entities/delivery.dart';

abstract class DeliveryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliveryAvailableLoaded extends DeliveryState {
  final List<Delivery> deliveries;
  DeliveryAvailableLoaded({required this.deliveries});
  @override
  List<Object?> get props => [deliveries];
}

class DeliveryMyListLoaded extends DeliveryState {
  final List<Delivery> deliveries;
  final int weeklyEarnings;
  DeliveryMyListLoaded({required this.deliveries, required this.weeklyEarnings});
  @override
  List<Object?> get props => [deliveries, weeklyEarnings];
}

class DeliveryAccepted extends DeliveryState {
  final Delivery delivery;
  DeliveryAccepted({required this.delivery});
  @override
  List<Object?> get props => [delivery];
}

class DeliveryStatusUpdated extends DeliveryState {
  final Delivery delivery;
  DeliveryStatusUpdated({required this.delivery});
  @override
  List<Object?> get props => [delivery];
}

class DeliveryError extends DeliveryState {
  final String message;
  DeliveryError({required this.message});
  @override
  List<Object?> get props => [message];
}
