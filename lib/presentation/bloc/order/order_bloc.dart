import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/usecases/orders/create_order_usecase.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final CreateOrderUseCase createOrder;

  OrderBloc({required this.orderRepository, required this.createOrder})
      : super(OrderInitial()) {
    on<OrderLoadMyPurchasesRequested>(_onLoadPurchases);
    on<OrderLoadMySalesRequested>(_onLoadSales);
    on<OrderCreateRequested>(_onCreate);
    on<OrderDetailRequested>(_onDetail);
    on<OrderReportIssueRequested>(_onReport);
  }

  Future<void> _onLoadPurchases(OrderLoadMyPurchasesRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await orderRepository.getMyOrders();
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (orders) => emit(OrderListLoaded(orders: orders, isBuyerView: true)),
    );
  }

  Future<void> _onLoadSales(OrderLoadMySalesRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await orderRepository.getMySales();
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (orders) => emit(OrderListLoaded(orders: orders, isBuyerView: false)),
    );
  }

  Future<void> _onCreate(OrderCreateRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await createOrder(CreateOrderParams(
      productId: event.productId,
      deliveryAddress: event.deliveryAddress,
    ));
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (order) => emit(OrderCreated(order: order)),
    );
  }

  Future<void> _onDetail(OrderDetailRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await orderRepository.getOrderById(event.orderId);
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (order) => emit(OrderDetailLoaded(order: order)),
    );
  }

  Future<void> _onReport(OrderReportIssueRequested event, Emitter<OrderState> emit) async {
    final result = await orderRepository.reportIssue(event.orderId, event.reason);
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (_) => null,
    );
  }
}
