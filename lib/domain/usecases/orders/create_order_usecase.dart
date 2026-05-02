import 'package:dartz/dartz.dart' hide Order;
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order.dart';
import '../../repositories/order_repository.dart';

class CreateOrderUseCase extends UseCase<Order, CreateOrderParams> {
  final OrderRepository repository;
  CreateOrderUseCase(this.repository);

  @override
  Future<Either<Failure, Order>> call(CreateOrderParams params) {
    return repository.createOrder(
      productId: params.productId,
      deliveryAddress: params.deliveryAddress,
    );
  }
}

class CreateOrderParams {
  final String productId;
  final DeliveryAddress deliveryAddress;
  const CreateOrderParams({required this.productId, required this.deliveryAddress});
}
