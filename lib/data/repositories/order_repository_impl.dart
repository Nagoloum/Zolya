import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient apiClient;

  OrderRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, Order>> createOrder({
    required String productId,
    required DeliveryAddress deliveryAddress,
  }) async {
    try {
      final response = await apiClient.post(ApiEndpoints.orders, data: {
        'product_id': productId,
        'delivery_address': {
          'neighborhood': deliveryAddress.neighborhood,
          'street': deliveryAddress.street,
          'landmark': deliveryAddress.landmark,
          'phone': deliveryAddress.phone,
          'zone': deliveryAddress.zone.name,
          'instructions': deliveryAddress.instructions,
        },
      });
      return Right(OrderModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String id) async {
    try {
      final response = await apiClient.get(ApiEndpoints.orderById(id));
      return Right(OrderModel.fromJson(response.data as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getMyOrders() async {
    try {
      final response = await apiClient.get(ApiEndpoints.myPurchases);
      final list = (response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getMySales() async {
    try {
      final response = await apiClient.get(ApiEndpoints.orders, queryParameters: {'role': 'seller'});
      final list = (response.data['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> reportIssue(String orderId, String reason) async {
    try {
      await apiClient.post(ApiEndpoints.reportIssue(orderId), data: {'reason': reason});
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
