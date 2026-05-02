import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderLoadMyPurchasesRequested extends OrderEvent {}

class OrderLoadMySalesRequested extends OrderEvent {}

class OrderCreateRequested extends OrderEvent {
  final String productId;
  final DeliveryAddress deliveryAddress;
  OrderCreateRequested({required this.productId, required this.deliveryAddress});
  @override
  List<Object?> get props => [productId];
}

class OrderDetailRequested extends OrderEvent {
  final String orderId;
  OrderDetailRequested({required this.orderId});
  @override
  List<Object?> get props => [orderId];
}

class OrderReportIssueRequested extends OrderEvent {
  final String orderId;
  final String reason;
  OrderReportIssueRequested({required this.orderId, required this.reason});
  @override
  List<Object?> get props => [orderId, reason];
}
