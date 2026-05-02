import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderListLoaded extends OrderState {
  final List<Order> orders;
  final bool isBuyerView;
  OrderListLoaded({required this.orders, required this.isBuyerView});
  @override
  List<Object?> get props => [orders, isBuyerView];
}

class OrderDetailLoaded extends OrderState {
  final Order order;
  OrderDetailLoaded({required this.order});
  @override
  List<Object?> get props => [order];
}

class OrderCreated extends OrderState {
  final Order order;
  OrderCreated({required this.order});
  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});
  @override
  List<Object?> get props => [message];
}
