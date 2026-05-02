import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/dispute.dart';

abstract class DisputeRepository {
  Future<Either<Failure, Dispute>> openDispute({
    required String orderId,
    required DisputeReason reason,
    required String description,
    List<String> attachmentUrls,
  });
  Future<Either<Failure, List<Dispute>>> getMyDisputes();
  Future<Either<Failure, Dispute>> getDisputeById(String id);
}
