import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/delivery_repository.dart';
import 'delivery_event.dart';
import 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final DeliveryRepository deliveryRepository;

  DeliveryBloc({required this.deliveryRepository}) : super(DeliveryInitial()) {
    on<DeliveryLoadAvailableRequested>(_onLoadAvailable);
    on<DeliveryLoadMyDeliveriesRequested>(_onLoadMine);
    on<DeliveryAcceptRequested>(_onAccept);
    on<DeliveryStatusUpdateRequested>(_onUpdateStatus);
    on<DeliveryLoadEarningsRequested>(_onLoadEarnings);
  }

  Future<void> _onLoadAvailable(DeliveryLoadAvailableRequested event, Emitter<DeliveryState> emit) async {
    emit(DeliveryLoading());
    final result = await deliveryRepository.getAvailableDeliveries();
    result.fold(
      (failure) => emit(DeliveryError(message: failure.message)),
      (deliveries) => emit(DeliveryAvailableLoaded(deliveries: deliveries)),
    );
  }

  Future<void> _onLoadMine(DeliveryLoadMyDeliveriesRequested event, Emitter<DeliveryState> emit) async {
    emit(DeliveryLoading());
    final deliveriesResult = await deliveryRepository.getMyDeliveries();
    if (deliveriesResult.isLeft()) {
      emit(DeliveryError(message: deliveriesResult.fold((f) => f.message, (_) => '')));
      return;
    }
    final earningsResult = await deliveryRepository.getWeeklyEarnings();
    final deliveries = deliveriesResult.getOrElse(() => []);
    final earnings = earningsResult.getOrElse(() => 0);
    emit(DeliveryMyListLoaded(deliveries: deliveries, weeklyEarnings: earnings));
  }

  Future<void> _onAccept(DeliveryAcceptRequested event, Emitter<DeliveryState> emit) async {
    final result = await deliveryRepository.acceptDelivery(event.deliveryId);
    result.fold(
      (failure) => emit(DeliveryError(message: failure.message)),
      (delivery) => emit(DeliveryAccepted(delivery: delivery)),
    );
  }

  Future<void> _onUpdateStatus(DeliveryStatusUpdateRequested event, Emitter<DeliveryState> emit) async {
    final result = await deliveryRepository.updateStatus(event.deliveryId, event.status);
    result.fold(
      (failure) => emit(DeliveryError(message: failure.message)),
      (delivery) => emit(DeliveryStatusUpdated(delivery: delivery)),
    );
  }

  Future<void> _onLoadEarnings(DeliveryLoadEarningsRequested event, Emitter<DeliveryState> emit) async {
    final result = await deliveryRepository.getWeeklyEarnings();
    result.fold(
      (failure) => emit(DeliveryError(message: failure.message)),
      (_) => null,
    );
  }
}
